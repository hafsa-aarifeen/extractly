import 'parsed_receipt.dart';

/// Independently checks a parsed receipt and reports why it might need review.
///
/// The model's output is a starting point, not the truth. This validator is
/// the app's own judgement: it verifies the numbers reconcile and the core
/// fields are present, so we can surface uncertain extractions to the user
/// instead of silently trusting them.
class ReceiptValidator {
  const ReceiptValidator();

  /// Returns a list of human-readable reasons the receipt needs review.
  /// Empty list means it passed every check.
  List<String> validate(ParsedReceipt r) {
    final reasons = <String>[];

    if (r.merchantName == null || r.merchantName!.trim().isEmpty) {
      reasons.add('Merchant name is missing');
    }
    if (r.total == null) {
      reasons.add('Total amount is missing');
    }

    // Do subtotal + tax + tip reconcile with the total?
    final subtotal = r.subtotal;
    final total = r.total;
    if (subtotal != null && total != null) {
      final expected = subtotal + (r.tax ?? 0) + (r.tip ?? 0);
      // Tolerance: 2% of the total, but at least 0.05, to absorb rounding.
      final tolerance = (total.abs() * 0.02).clamp(0.05, double.infinity);
      if ((expected - total).abs() > tolerance) {
        reasons.add('Subtotal + tax + tip does not match the total');
      }
    }

    if (r.items.isEmpty) {
      reasons.add('No line items were found');
    }

    return reasons;
  }
}
