import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kalkulator2/main.dart';

void main() {
  testWidgets('Pressing button 1 updates displayed value', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    // Verify that the initial displayed value is an empty string.
    expect(find.text(''), findsOneWidget);

    // Tap the button '1' and trigger a frame.
    await tester.tap(find.text('1'));
    await tester.pump();

    // Verify that the displayed value has changed to '1'.
    expect(find.text('1'), findsOneWidget);
  });
}
