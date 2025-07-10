import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mamoyee/main.dart';

void main() {
  testWidgets('Mamoyee app loads onboarding screen and navigates to home', (WidgetTester tester) async {
    // Build the Mamoyee app
    await tester.pumpWidget(const MamoyeeApp());

    // Check for onboarding screen text and button
    expect(find.text('Welcome to PPD Support App'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap the 'Get Started' button to navigate to Home
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify navigation to home screen with welcome text
    expect(find.text('Welcome, Kentlee!'), findsOneWidget);
  });
}
