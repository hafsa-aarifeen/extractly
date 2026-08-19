import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/gemini/gemini_extraction_service.dart';
import '../data/receipt_repository.dart';

/// The single database instance for the app's lifetime.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// The repository, wired to the database above.
final receiptRepositoryProvider = Provider<ReceiptRepository>((ref) {
  return ReceiptRepository(ref.watch(appDatabaseProvider));
});

/// The Gemini extraction service.
final geminiExtractionServiceProvider = Provider<GeminiExtractionService>((
  ref,
) {
  final service = GeminiExtractionService();
  ref.onDispose(service.dispose);
  return service;
});

/// Live list of all saved receipts. The UI watches this; it updates itself
/// whenever the database changes.
final receiptListProvider = StreamProvider<List<Receipt>>((ref) {
  return ref.watch(receiptRepositoryProvider).watchAllReceipts();
});
