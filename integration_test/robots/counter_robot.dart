import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tests/main.dart';

class CounterRobot {
  CounterRobot({required this.tester});

  final WidgetTester tester;

  Future<void> show(int initialValue) {
    return tester.pumpWidget(
      MyApp(count: initialValue),
    );
  }

  Future<void> tapIncrementButton() async {
    final incButton = find.byKey(CounterKey.incrementCounterButton);
    await tester.tap(incButton);
    await tester.pump();
  }

  Future<void> verifyCounterValue(int value) async {
    final counterTextFinder = find.byKey(CounterKey.counterTextValue);
    final counterTextWidget = tester.widget<Text>(counterTextFinder);
    final counterTextValue = counterTextWidget.data;

    expect(
      int.tryParse(counterTextValue ?? ''),
      equals(value),
    );
  }
}
