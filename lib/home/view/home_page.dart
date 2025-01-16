import 'package:flutter/material.dart';
import 'package:integration_tests/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
