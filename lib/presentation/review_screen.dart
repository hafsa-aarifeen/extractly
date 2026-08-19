import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/extraction_result.dart';
import 'providers.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key, required this.success});

  final ExtractionSuccess success;

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  late final TextEditingController _merchant;
  late final TextEditingController _date;
  late final TextEditingController _currency;
  late final TextEditingController _total;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final r = widget.success.receipt;
    _merchant = TextEditingController(text: r.merchantName ?? '');
    _date = TextEditingController(text: r.date ?? '');
    _currency = TextEditingController(text: r.currency ?? '');
    _total = TextEditingController(text: r.total?.toStringAsFixed(2) ?? '');
  }

  @override
  void dispose() {
    _merchant.dispose();
    _date.dispose();
    _currency.dispose();
    _total.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);

    final original = widget.success.receipt;
    final edited = original.copyWith(
      merchantName: _merchant.text.trim().isEmpty
          ? null
          : _merchant.text.trim(),
      date: _date.text.trim().isEmpty ? null : _date.text.trim(),
      currency: _currency.text.trim().isEmpty ? null : _currency.text.trim(),
      total: double.tryParse(_total.text.trim()),
    );

    await ref
        .read(receiptRepositoryProvider)
        .saveParsed(edited, needsReview: widget.success.needsReview);

    if (!mounted) return;
    // Pop back to Home; the list updates itself via the stream.
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final success = widget.success;
    final items = success.receipt.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (success.needsReview)
            _ReviewBanner(reasons: success.reviewReasons),
          TextField(
            controller: _merchant,
            decoration: const InputDecoration(labelText: 'Merchant'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _date,
            decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _currency,
                  decoration: const InputDecoration(labelText: 'Currency'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _total,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Total'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Items (${items.length})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (items.isEmpty)
            const Text('No line items detected.')
          else
            ...items.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.description),
                trailing: Text(item.total?.toStringAsFixed(2) ?? '—'),
              ),
            ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(_saving ? 'Saving...' : 'Save receipt'),
          ),
        ],
      ),
    );
  }
}

class _ReviewBanner extends StatelessWidget {
  const _ReviewBanner({required this.reasons});

  final List<String> reasons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text(
                'Please double-check:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...reasons.map((r) => Text('• $r')),
        ],
      ),
    );
  }
}
