import 'package:flutter_test/flutter_test.dart';
import 'package:extractly/domain/parsed_receipt.dart';
import 'package:extractly/domain/receipt_validator.dart';

void main() {
  const validator = ReceiptValidator();

  test('a clean, reconciling receipt passes with no reasons', () {
    const receipt = ParsedReceipt(
      merchantName: 'Cafe Aroma',
      subtotal: 100,
      tax: 10,
      tip: 5,
      total: 115,
      items: [ParsedLineItem(description: 'Coffee', total: 100)],
    );

    expect(validator.validate(receipt), isEmpty);
  });

  test('missing merchant name is flagged', () {
    const receipt = ParsedReceipt(
      total: 50,
      items: [ParsedLineItem(description: 'Item', total: 50)],
    );

    expect(validator.validate(receipt), contains('Merchant name is missing'));
  });

  test('missing total is flagged', () {
    const receipt = ParsedReceipt(
      merchantName: 'Shop',
      items: [ParsedLineItem(description: 'Item')],
    );

    expect(validator.validate(receipt), contains('Total amount is missing'));
  });

  test('totals that do not reconcile are flagged', () {
    const receipt = ParsedReceipt(
      merchantName: 'Shop',
      subtotal: 100,
      tax: 10,
      total: 200, // should be ~110
      items: [ParsedLineItem(description: 'Item', total: 100)],
    );

    expect(
      validator.validate(receipt),
      contains('Subtotal + tax + tip does not match the total'),
    );
  });

  test('small rounding differences are tolerated', () {
    const receipt = ParsedReceipt(
      merchantName: 'Shop',
      subtotal: 100,
      tax: 9.99,
      total: 110, // off by 0.01 — within tolerance
      items: [ParsedLineItem(description: 'Item', total: 100)],
    );

    expect(
      validator.validate(receipt),
      isNot(contains('Subtotal + tax + tip does not match the total')),
    );
  });

  test('empty items list is flagged', () {
    const receipt = ParsedReceipt(merchantName: 'Shop', total: 50, items: []);

    expect(validator.validate(receipt), contains('No line items were found'));
  });
}
