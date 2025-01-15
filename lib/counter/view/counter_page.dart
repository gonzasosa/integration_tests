import 'package:flutter/material.dart';
import 'package:integration_tests/counter/counter.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({
    super.key,
  });

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => CounterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CounterView(
      title: 'Counter App',
      count: 0,
    );
  }
}
