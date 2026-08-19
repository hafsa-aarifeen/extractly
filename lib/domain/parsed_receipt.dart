/// Safely coerces a JSON number (int, double, or numeric string) to double.
double? _asDouble(Object? value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

/// A single line item as returned by the model.
class ParsedLineItem {
  const ParsedLineItem({
    required this.description,
    this.quantity,
    this.unitPrice,
    this.total,
  });

  final String description;
  final double? quantity;
  final double? unitPrice;
  final double? total;

  factory ParsedLineItem.fromJson(Map<String, dynamic> json) {
    return ParsedLineItem(
      description: (json['description'] as String?)?.trim() ?? '',
      quantity: _asDouble(json['quantity']),
      unitPrice: _asDouble(json['unit_price']),
      total: _asDouble(json['total']),
    );
  }
}

/// A full receipt as returned by the model, before validation.
class ParsedReceipt {
  const ParsedReceipt({
    this.merchantName,
    this.merchantAddress,
    this.merchantPhone,
    this.currency,
    this.date,
    this.time,
    this.subtotal,
    this.tax,
    this.tip,
    this.total,
    this.paymentMethod,
    this.items = const [],
  });

  final String? merchantName;
  final String? merchantAddress;
  final String? merchantPhone;
  final String? currency;
  final String? date;
  final String? time;
  final double? subtotal;
  final double? tax;
  final double? tip;
  final double? total;
  final String? paymentMethod;
  final List<ParsedLineItem> items;

  factory ParsedReceipt.fromJson(Map<String, dynamic> json) {
    final merchant = json['merchant'] as Map<String, dynamic>? ?? const {};
    final totals = json['totals'] as Map<String, dynamic>? ?? const {};
    final rawItems = json['items'] as List<dynamic>? ?? const [];

    return ParsedReceipt(
      merchantName: merchant['name'] as String?,
      merchantAddress: merchant['address'] as String?,
      merchantPhone: merchant['phone'] as String?,
      currency: json['currency'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      subtotal: _asDouble(totals['subtotal']),
      tax: _asDouble(totals['tax']),
      tip: _asDouble(totals['tip']),
      total: _asDouble(totals['total']),
      paymentMethod: json['payment_method'] as String?,
      items: rawItems
          .whereType<Map<String, dynamic>>()
          .map(ParsedLineItem.fromJson)
          .where((item) => item.description.isNotEmpty)
          .toList(),
    );
  }

  /// A copy with fields replaced — used by the review screen's editing.
  ParsedReceipt copyWith({
    String? merchantName,
    String? currency,
    String? date,
    double? total,
    List<ParsedLineItem>? items,
  }) {
    return ParsedReceipt(
      merchantName: merchantName ?? this.merchantName,
      merchantAddress: merchantAddress,
      merchantPhone: merchantPhone,
      currency: currency ?? this.currency,
      date: date ?? this.date,
      time: time,
      subtotal: subtotal,
      tax: tax,
      tip: tip,
      total: total ?? this.total,
      paymentMethod: paymentMethod,
      items: items ?? this.items,
    );
  }
}
