import 'package:flutter/material.dart';

abstract class CounterKey {
  static const incrementCounterButton = ValueKey('incrementCounterButton');
  static const counterTextValue = ValueKey('counterTextValue');
}

class CounterView extends StatefulWidget {
  const CounterView({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.count;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              key: CounterKey.counterTextValue,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: CounterKey.incrementCounterButton,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
