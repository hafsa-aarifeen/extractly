import 'package:drift/drift.dart';

/// One row per scanned receipt.
class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get merchantName => text().nullable()();
  TextColumn get merchantAddress => text().nullable()();
  TextColumn get merchantPhone => text().nullable()();

  TextColumn get currency => text().nullable()();
  TextColumn get date =>
      text().nullable()(); // ISO 8601 string, e.g. 2026-08-19
  TextColumn get time => text().nullable()();

  RealColumn get subtotal => real().nullable()();
  RealColumn get tax => real().nullable()();
  RealColumn get tip => real().nullable()();
  RealColumn get total => real().nullable()();

  TextColumn get paymentMethod => text().nullable()();

  /// True when totals don't reconcile or a core field was missing/low-confidence.
  BoolColumn get needsReview => boolean().withDefault(const Constant(false))();

  /// Local file path of the captured photo (set in a later phase).
  TextColumn get imagePath => text().nullable()();

  /// When this receipt was saved on the device.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Line items belonging to a receipt (one-to-many).
class ReceiptItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key → Receipts.id. Deleting a receipt deletes its items.
  IntColumn get receiptId =>
      integer().references(Receipts, #id, onDelete: KeyAction.cascade)();

  TextColumn get description => text()();
  RealColumn get quantity => real().nullable()();
  RealColumn get unitPrice => real().nullable()();
  RealColumn get total => real().nullable()();
}
