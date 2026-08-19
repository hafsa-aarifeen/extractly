import 'package:drift/drift.dart';

import 'database/app_database.dart';

/// A receipt plus its line items, returned together for the UI.
class ReceiptWithItems {
  const ReceiptWithItems({required this.receipt, required this.items});

  final Receipt receipt;
  final List<ReceiptItem> items;
}

/// The single entry point for all receipt persistence.
///
/// The rest of the app depends on this, never on [AppDatabase] directly —
/// so the storage details stay swappable and testable.
class ReceiptRepository {
  ReceiptRepository(this._db);

  final AppDatabase _db;

  /// Inserts a receipt and its items in one transaction, returning the new id.
  ///
  /// The transaction guarantees we never end up with a receipt that has
  /// half its line items — either all rows commit, or none do.
  Future<int> saveReceipt({
    required ReceiptsCompanion receipt,
    required List<ReceiptItemsCompanion> items,
  }) {
    return _db.transaction(() async {
      final receiptId = await _db.into(_db.receipts).insert(receipt);

      for (final item in items) {
        await _db
            .into(_db.receiptItems)
            .insert(item.copyWith(receiptId: Value(receiptId)));
      }

      return receiptId;
    });
  }

  /// All receipts, newest first.
  Future<List<Receipt>> getAllReceipts() {
    return (_db.select(
      _db.receipts,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  /// A live stream of all receipts, newest first. Emits a new list whenever
  /// the underlying table changes — this is what makes the UI auto-update.
  Stream<List<Receipt>> watchAllReceipts() {
    return (_db.select(
      _db.receipts,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  }

  /// A single receipt with its line items, or null if it doesn't exist.
  Future<ReceiptWithItems?> getReceiptById(int id) async {
    final receipt = await (_db.select(
      _db.receipts,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (receipt == null) return null;

    final items = await (_db.select(
      _db.receiptItems,
    )..where((t) => t.receiptId.equals(id))).get();

    return ReceiptWithItems(receipt: receipt, items: items);
  }

  /// Deletes a receipt. Its line items go too, via the cascade FK.
  Future<void> deleteReceipt(int id) {
    return (_db.delete(_db.receipts)..where((t) => t.id.equals(id))).go();
  }
}
