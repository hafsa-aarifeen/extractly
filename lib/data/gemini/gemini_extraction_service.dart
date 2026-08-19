import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:extractly/domain/extraction_result.dart';
import 'package:extractly/domain/parsed_receipt.dart';
import 'package:extractly/domain/receipt_validator.dart';

import 'gemini_config.dart';
import 'receipt_schema.dart';

/// Calls the Gemini REST API to extract structured receipt data from an image.
///
/// Reliability is the whole point of this class:
///  - the request pins a JSON schema, so the model is constrained, not trusted;
///  - transient failures (network, 429 rate-limit, 5xx, malformed JSON) are
///    retried with exponential backoff + jitter;
///  - permanent failures (bad key, 4xx) fail fast with a clear message;
///  - the parsed result is validated before it's ever returned as success.
class GeminiExtractionService {
  GeminiExtractionService({
    http.Client? client,
    ReceiptValidator? validator,
    this.maxAttempts = 3,
  }) : _client = client ?? http.Client(),
       _validator = validator ?? const ReceiptValidator(),
       _clientInjected = client != null;

  /// True when a caller supplied the HTTP client (i.e. in tests). When true,
  /// we skip the real API-key gate so tests run without a key.
  final bool _clientInjected;

  static const String model = 'gemini-3.6-flash';
  static const Duration _requestTimeout = Duration(seconds: 60);

  final http.Client _client;
  final ReceiptValidator _validator;

  /// How many total attempts before giving up (1 initial + retries).
  final int maxAttempts;

  Uri get _endpoint => Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent',
  );

  /// Extracts a receipt from [imageBytes]. Always resolves to an
  /// [ExtractionResult]; it never throws.
  Future<ExtractionResult> extract(
    Uint8List imageBytes, {
    String mimeType = 'image/jpeg',
  }) async {
    if (!_clientInjected && !GeminiConfig.hasKey) {
      return const ExtractionFailure(
        'No API key configured. Pass --dart-define-from-file=env.json when running.',
      );
    }

    final body = jsonEncode(_buildRequest(imageBytes, mimeType));
    final random = Random();

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final isLastAttempt = attempt == maxAttempts - 1;

      try {
        final response = await _client
            .post(
              _endpoint,
              headers: {
                'Content-Type': 'application/json',
                'x-goog-api-key': GeminiConfig.apiKey,
              },
              body: body,
            )
            .timeout(_requestTimeout);

        // Retryable server-side conditions: rate limit or server error.
        if (response.statusCode == 429 || response.statusCode >= 500) {
          if (isLastAttempt) {
            return ExtractionFailure(
              'Gemini is busy (HTTP ${response.statusCode}). Try again shortly.',
            );
          }
          await _backoff(attempt, random);
          continue;
        }

        // Permanent client errors: don't retry, surface immediately.
        if (response.statusCode != 200) {
          return ExtractionFailure(
            'Gemini request failed (HTTP ${response.statusCode}).',
          );
        }

        final modelJson = _extractModelJson(response.body);
        if (modelJson == null) {
          // Model returned something unparseable — treat as transient.
          if (isLastAttempt) {
            return const ExtractionFailure(
              'Could not read a valid response from the model.',
            );
          }
          await _backoff(attempt, random);
          continue;
        }

        return _toResult(modelJson);
      } on Exception catch (_) {
        // Network error / timeout — retryable.
        if (isLastAttempt) {
          return const ExtractionFailure(
            'Network error reaching Gemini. Check your connection.',
          );
        }
        await _backoff(attempt, random);
      }
    }

    return const ExtractionFailure('Extraction failed after several attempts.');
  }

  /// Builds the request body: system instruction, the image + prompt, and the
  /// schema-constrained generation config.
  Map<String, Object?> _buildRequest(Uint8List imageBytes, String mimeType) {
    return {
      'systemInstruction': {
        'parts': [
          {'text': receiptSystemInstruction},
        ],
      },
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': 'Extract the receipt data from this image.'},
            {
              'inlineData': {
                'mimeType': mimeType,
                'data': base64Encode(imageBytes),
              },
            },
          ],
        },
      ],
      'generationConfig': {
        'responseMimeType': 'application/json',
        'responseSchema': receiptResponseSchema,
        'temperature': 0,
      },
    };
  }

  /// Pulls the model's JSON object out of the Gemini envelope. Returns null on
  /// any structural surprise so the caller can retry rather than crash.
  Map<String, dynamic>? _extractModelJson(String responseBody) {
    try {
      final decoded = jsonDecode(responseBody);
      if (decoded is! Map<String, dynamic>) return null;

      final candidates = decoded['candidates'];
      if (candidates is! List || candidates.isEmpty) return null;

      final content = (candidates.first as Map<String, dynamic>)['content'];
      if (content is! Map<String, dynamic>) return null;

      final parts = content['parts'];
      if (parts is! List || parts.isEmpty) return null;

      final buffer = StringBuffer();
      for (final part in parts) {
        if (part is Map<String, dynamic> && part['text'] is String) {
          buffer.write(part['text']);
        }
      }

      final text = buffer.toString().trim();
      if (text.isEmpty) return null;

      final modelJson = jsonDecode(text);
      return modelJson is Map<String, dynamic> ? modelJson : null;
    } on Exception {
      return null;
    }
  }

  /// Maps parsed JSON to a domain result, running validation on success.
  ExtractionResult _toResult(Map<String, dynamic> json) {
    if (json['status'] == 'not_a_receipt') {
      return const ExtractionNotAReceipt();
    }

    final receipt = ParsedReceipt.fromJson(json);
    final reasons = _validator.validate(receipt);

    return ExtractionSuccess(
      receipt: receipt,
      needsReview: reasons.isNotEmpty,
      reviewReasons: reasons,
    );
  }

  /// Exponential backoff with jitter: ~0.4s, ~1.2s, ~3.6s (+ up to 250ms).
  Future<void> _backoff(int attempt, Random random) {
    final base = 400 * pow(3, attempt).toInt();
    final jitter = random.nextInt(250);
    return Future.delayed(Duration(milliseconds: base + jitter));
  }

  void dispose() => _client.close();
}
