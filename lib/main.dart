import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_tests/login/login.dart';

void main() {
  runApp(
    App(
      count: 0,
      authRepository: AuthRepository(),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.count,
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final int count;
  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage(),
      ),
    );
  }
}
