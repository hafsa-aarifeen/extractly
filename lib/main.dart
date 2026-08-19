import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'data/gemini/gemini_extraction_service.dart';
import 'domain/extraction_result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Extractly',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const ExtractionTestScreen(),
    );
  }
}

/// TEMPORARY: runs extraction on a bundled sample image so we can see the
/// Gemini pipeline work end to end. Replaced by the real capture flow in Phase 4.
class ExtractionTestScreen extends StatefulWidget {
  const ExtractionTestScreen({super.key});

  @override
  State<ExtractionTestScreen> createState() => _ExtractionTestScreenState();
}

class _ExtractionTestScreenState extends State<ExtractionTestScreen> {
  final _service = GeminiExtractionService();

  bool _loading = false;
  String _output = 'Tap "Extract sample" to run the Gemini pipeline.';

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  Future<void> _runExtraction() async {
    setState(() {
      _loading = true;
      _output = 'Loading image and calling Gemini...';
    });

    try {
      final data = await rootBundle.load('assets/sample_receipt.jpg');
      final bytes = data.buffer.asUint8List();

      final result = await _service.extract(bytes);

      setState(() => _output = _describe(result));
    } catch (e) {
      setState(() => _output = 'Error loading asset: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  String _describe(ExtractionResult result) {
    switch (result) {
      case ExtractionSuccess(
        :final receipt,
        :final needsReview,
        :final reviewReasons,
      ):
        final buffer = StringBuffer()
          ..writeln('✅ EXTRACTED')
          ..writeln('Merchant: ${receipt.merchantName ?? "—"}')
          ..writeln('Date: ${receipt.date ?? "—"}')
          ..writeln('Currency: ${receipt.currency ?? "—"}')
          ..writeln('Total: ${receipt.total?.toStringAsFixed(2) ?? "—"}')
          ..writeln('Items (${receipt.items.length}):');
        for (final item in receipt.items) {
          buffer.writeln(
            '  • ${item.description} '
            '${item.total?.toStringAsFixed(2) ?? ""}',
          );
        }
        buffer.writeln('');
        buffer.writeln(
          needsReview ? '⚠️ Needs review:' : '✔ Passed validation',
        );
        for (final reason in reviewReasons) {
          buffer.writeln('  - $reason');
        }
        return buffer.toString();

      case ExtractionNotAReceipt():
        return '🚫 Not a receipt.';

      case ExtractionFailure(:final message):
        return '❌ Failed: $message';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extractly — extraction test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            _output,
            style: const TextStyle(fontFamily: 'monospace', height: 1.4),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _runExtraction,
        icon: _loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.document_scanner),
        label: Text(_loading ? 'Working...' : 'Extract sample'),
      ),
    );
  }
}
