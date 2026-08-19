import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import 'providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptsAsync = ref.watch(receiptListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Extractly')),
      body: receiptsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (receipts) {
          if (receipts.isEmpty) {
            return const _EmptyState();
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: receipts.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, i) => _ReceiptTile(receipt: receipts[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Wired to the capture flow in Part B.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Capture flow comes next (Part B)')),
          );
        },
        icon: const Icon(Icons.add_a_photo_outlined),
        label: const Text('Scan receipt'),
      ),
    );
  }
}

class _ReceiptTile extends StatelessWidget {
  const _ReceiptTile({required this.receipt});

  final Receipt receipt;

  @override
  Widget build(BuildContext context) {
    final total = receipt.total?.toStringAsFixed(2) ?? '—';
    final currency = receipt.currency ?? '';

    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.receipt_long)),
      title: Text(receipt.merchantName ?? '(no merchant)'),
      subtitle: Text(receipt.date ?? 'No date'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$currency $total',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (receipt.needsReview)
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                'Needs review',
                style: TextStyle(fontSize: 11, color: Colors.orange),
              ),
            ),
        ],
      ),
      onTap: () {
        // Wired to the detail screen in Part C.
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 72,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          const Text('No receipts yet'),
          const SizedBox(height: 4),
          Text(
            'Tap "Scan receipt" to add your first one.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
