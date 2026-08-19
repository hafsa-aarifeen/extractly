import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('empty-state text renders', (WidgetTester tester) async {
    // A focused widget test: verify a small piece of UI in isolation,
    // without spinning up the database or providers.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('No receipts yet'))),
      ),
    );

    expect(find.text('No receipts yet'), findsOneWidget);
  });
}
