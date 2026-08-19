import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/database/app_database.dart';
import '../domain/extraction_result.dart';
import 'capture_controller.dart';
import 'providers.dart';
import 'review_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _startCapture(BuildContext context, WidgetRef ref) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final controller = ref.read(captureControllerProvider.notifier);
    controller.reset();
    await controller.pickAndExtract(source);

    if (!context.mounted) return;
    final state = ref.read(captureControllerProvider);

    if (state.status == CaptureStatus.error) {
      _showError(context, state.message ?? 'Unknown error');
      return;
    }

    final result = state.result;
    switch (result) {
      case ExtractionSuccess():
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ReviewScreen(success: result)),
        );
      case ExtractionNotAReceipt():
        _showError(
          context,
          "That doesn't look like a receipt. Try another photo.",
        );
      case ExtractionFailure(:final message):
        _showError(context, message);
      case null:
        break; // user cancelled the picker
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptsAsync = ref.watch(receiptListProvider);
    final capturing =
        ref.watch(captureControllerProvider).status == CaptureStatus.working;

    return Scaffold(
      appBar: AppBar(title: const Text('Extractly')),
      body: Stack(
        children: [
          receiptsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
            data: (receipts) {
              if (receipts.isEmpty) return const _EmptyState();
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: receipts.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, i) => _ReceiptTile(receipt: receipts[i]),
              );
            },
          ),
          if (capturing)
            Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Reading receipt...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: capturing ? null : () => _startCapture(context, ref),
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
      onTap: () {}, // detail screen in Part C
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
