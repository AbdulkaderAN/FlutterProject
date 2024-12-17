import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practical/main.dart';

void main() {
  testWidgets('Sign In screen test', (WidgetTester tester) async {
    await tester.pumpWidget(TaskManagerApp());

    expect(find.text('Sign In'), findsOneWidget);

    expect(find.byType(TextField), findsNWidgets(2));

    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Invalid email or password'), findsOneWidget);
  });
}
