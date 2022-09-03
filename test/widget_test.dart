import 'package:flutter_assignment/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets(
    'test app widget and check for CircularProgressIndicator',
    (WidgetTester tester) async {
      await tester.runAsync(() => tester.pumpWidget(const App()));
      const indicator = CircularProgressIndicator();
      await tester.pumpWidget(indicator);
      expect(find.byWidget(indicator), findsOneWidget);
    },
  );
}
