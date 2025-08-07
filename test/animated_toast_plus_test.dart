import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_toast_plus/animated_toast_plus.dart';

void main() {
  testWidgets('showSuccess does not crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Placeholder())),
    );

    AnimatedToastPlus.showSuccess(
      tester.element(find.byType(Placeholder)),
      title: 'Success',
      subtitle: 'Everything went fine!',
    );

    await tester.pump(); // Start animation
    await tester.pump(const Duration(seconds: 3)); // Let the toast disappear
  });

  testWidgets('showError does not crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Placeholder())),
    );

    AnimatedToastPlus.showError(
      tester.element(find.byType(Placeholder)),
      title: 'Error',
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('showWarning does not crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Placeholder())),
    );

    AnimatedToastPlus.showWarning(
      tester.element(find.byType(Placeholder)),
      title: 'Warning',
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('showInfo does not crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Placeholder())),
    );

    AnimatedToastPlus.showInfo(
      tester.element(find.byType(Placeholder)),
      title: 'Info',
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('Custom show() does not crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Placeholder())),
    );

    AnimatedToastPlus.show(
      tester.element(find.byType(Placeholder)),
      title: 'Custom Toast',
      subtitle: 'This is a custom toast',
      backgroundColor: Colors.teal,
      position: ToastPosition.center,
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
  });
}
