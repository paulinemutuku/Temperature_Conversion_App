import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_conversion_app/main.dart';


void main() {
  testWidgets('Temperature conversion test', (WidgetTester tester) async {
    // Build the Temperature Converter app and trigger a frame.
    await tester.pumpWidget(TemperatureConverterApp());

    // Verify that the dropdown and text field are present.
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Enter a temperature value.
    await tester.enterText(find.byType(TextField), '100');

    // Select Celsius to Fahrenheit conversion.
    await tester.tap(find.text('Fahrenheit to Celsius'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Celsius to Fahrenheit').last);
    await tester.pumpAndSettle();

    // Tap the Convert button.
    await tester.tap(find.text('CONVERT'));
    await tester.pump();

    // Verify the converted value is displayed correctly.
    expect(find.text('212.0'), findsOneWidget);

    // Verify the history entry.
    expect(find.text('C to F: 100.0 => 212.0'), findsOneWidget);
  });
}
