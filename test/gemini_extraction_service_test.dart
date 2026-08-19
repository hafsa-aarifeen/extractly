import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:extractly/data/gemini/gemini_extraction_service.dart';
import 'package:extractly/domain/extraction_result.dart';

/// Wraps a model-JSON object in the same envelope the Gemini API returns.
String geminiEnvelope(Object modelJson) {
  return jsonEncode({
    'candidates': [
      {
        'content': {
          'parts': [
            {'text': jsonEncode(modelJson)},
          ],
        },
      },
    ],
  });
}

void main() {
  final fakeImage = Uint8List.fromList([1, 2, 3]);

  test('a valid receipt response maps to ExtractionSuccess', () async {
    final client = MockClient((request) async {
      return http.Response(
        geminiEnvelope({
          'status': 'ok',
          'merchant': {'name': 'Test Diner'},
          'currency': 'USD',
          'date': '2026-08-19',
          'items': [
            {'description': 'Burger', 'total': 12.5},
          ],
          'totals': {'subtotal': 12.5, 'total': 12.5},
        }),
        200,
      );
    });

    final service = GeminiExtractionService(client: client);
    final result = await service.extract(fakeImage);

    expect(result, isA<ExtractionSuccess>());
    final success = result as ExtractionSuccess;
    expect(success.receipt.merchantName, 'Test Diner');
    expect(success.receipt.items, hasLength(1));
  });

  test('a not_a_receipt response maps to ExtractionNotAReceipt', () async {
    final client = MockClient((request) async {
      return http.Response(geminiEnvelope({'status': 'not_a_receipt'}), 200);
    });

    final service = GeminiExtractionService(client: client);
    final result = await service.extract(fakeImage);

    expect(result, isA<ExtractionNotAReceipt>());
  });

  test('malformed JSON is retried, then fails after max attempts', () async {
    var calls = 0;
    final client = MockClient((request) async {
      calls++;
      return http.Response('this is not json', 200);
    });

    final service = GeminiExtractionService(client: client, maxAttempts: 3);
    final result = await service.extract(fakeImage);

    expect(result, isA<ExtractionFailure>());
    expect(calls, 3, reason: 'should retry up to maxAttempts');
  });

  test('a 429 that then succeeds is retried and returns success', () async {
    var calls = 0;
    final client = MockClient((request) async {
      calls++;
      if (calls == 1) {
        return http.Response('rate limited', 429);
      }
      return http.Response(
        geminiEnvelope({
          'status': 'ok',
          'merchant': {'name': 'Recovered Cafe'},
          'items': [
            {'description': 'Tea', 'total': 3},
          ],
          'totals': {'total': 3},
        }),
        200,
      );
    });

    final service = GeminiExtractionService(client: client, maxAttempts: 3);
    final result = await service.extract(fakeImage);

    expect(result, isA<ExtractionSuccess>());
    expect(calls, 2, reason: 'first 429, second succeeds');
  });

  test('a 400 fails fast without retrying', () async {
    var calls = 0;
    final client = MockClient((request) async {
      calls++;
      return http.Response('bad request', 400);
    });

    final service = GeminiExtractionService(client: client, maxAttempts: 3);
    final result = await service.extract(fakeImage);

    expect(result, isA<ExtractionFailure>());
    expect(calls, 1, reason: 'client errors are permanent, no retry');
  });
}
