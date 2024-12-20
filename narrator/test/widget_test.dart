import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:narrator/main.dart';

/// This test verifies that the Text Narrator app loads correctly,
/// displays the input field, and responds to button interactions.
void main() {
  testWidgets('Narration screen loads and widgets are functional', (WidgetTester tester) async {
    // Build the NarrateApp widget and trigger a frame.
    await tester.pumpWidget(const NarratorApp());

    // Verify that the text field is present.
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the "Narrate" button is present.
    expect(find.text('Narrate'), findsOneWidget);

    // Enter text into the text field.
    await tester.enterText(find.byType(TextField), 'Hello, world!');

    // Tap the "Narrate" button.
    await tester.tap(find.text('Narrate'));
    await tester.pump();

    // Simulate further interactions or assertions as needed.
    // For example, you could check for loading indicators or other UI changes.
  });
}
