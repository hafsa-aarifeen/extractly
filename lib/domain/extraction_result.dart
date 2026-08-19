import 'parsed_receipt.dart';

/// The outcome of one extraction attempt. Sealed so callers must handle
/// every case — success, not-a-receipt, and failure — with no silent gaps.
sealed class ExtractionResult {
  const ExtractionResult();
}

/// The model returned a receipt. [needsReview] is set by the validator when
/// totals don't reconcile or a core field is missing.
class ExtractionSuccess extends ExtractionResult {
  const ExtractionSuccess({
    required this.receipt,
    this.needsReview = false,
    this.reviewReasons = const [],
  });

  final ParsedReceipt receipt;
  final bool needsReview;
  final List<String> reviewReasons;
}

/// The image wasn't a receipt at all.
class ExtractionNotAReceipt extends ExtractionResult {
  const ExtractionNotAReceipt();
}

/// Something went wrong (network, bad response, no API key, etc.).
class ExtractionFailure extends ExtractionResult {
  const ExtractionFailure(this.message);
  final String message;
}
