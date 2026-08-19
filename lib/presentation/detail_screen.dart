import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/receipt_repository.dart';
import 'providers.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.receiptId});

  final int receiptId;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete receipt?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(receiptRepositoryProvider).deleteReceipt(receiptId);
    if (!context.mounted) return;
    Navigator.of(context).pop(); // back to Home; list updates via the stream
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(receiptRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: FutureBuilder<ReceiptWithItems?>(
        future: repo.getReceiptById(receiptId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: Text('Receipt not found.'));
          }

          final r = data.receipt;
          final currency = r.currency ?? '';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (r.needsReview)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text('This receipt was flagged for review.'),
                      ),
                    ],
                  ),
                ),
              Text(
                r.merchantName ?? '(no merchant)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                r.date ?? 'No date',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Divider(height: 32),
              _Row(label: 'Subtotal', value: _money(currency, r.subtotal)),
              _Row(label: 'Tax', value: _money(currency, r.tax)),
              _Row(label: 'Tip', value: _money(currency, r.tip)),
              const Divider(height: 24),
              _Row(
                label: 'Total',
                value: _money(currency, r.total),
                bold: true,
              ),
              const SizedBox(height: 24),
              Text(
                'Items (${data.items.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (data.items.isEmpty)
                const Text('No line items.')
              else
                ...data.items.map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.description),
                    subtitle: item.quantity != null
                        ? Text('Qty: ${item.quantity}')
                        : null,
                    trailing: Text(_money(currency, item.total)),
                  ),
                ),
              if (r.paymentMethod != null) ...[
                const Divider(height: 32),
                _Row(label: 'Payment', value: r.paymentMethod!),
              ],
            ],
          );
        },
      ),
    );
  }

  static String _money(String currency, double? value) {
    if (value == null) return '—';
    return '$currency ${value.toStringAsFixed(2)}'.trim();
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
        : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
