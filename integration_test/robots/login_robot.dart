import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tests/counter/counter.dart';
import 'package:integration_tests/login/login.dart';
import 'package:mocktail/mocktail.dart';

class LoginRobot {
  LoginRobot({
    required this.tester,
    required this.authRepository,
  });

  final WidgetTester tester;
  final AuthRepository authRepository;

  void setUpLoginSuccesful({
    required String email,
    required String password,
  }) {
    when(
      () => authRepository.login(
        email: email,
        password: password,
      ),
    ).thenAnswer((_) async {});
  }

  void setUpLoginFailure({
    required String email,
    required String password,
  }) {
    when(
      () => authRepository.login(
        email: email,
        password: password,
      ),
    ).thenThrow(Exception('Login failed'));
  }

  Future<void> show() async {
    await tester.pumpWidget(
      RepositoryProvider.value(
        value: authRepository,
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> enterEmail(String email) async {
    final emailField = find.byKey(ValueKey(LoginViewKeys.emailTextField));
    await tester.enterText(emailField, email);
    await tester.pump();
  }

  Future<void> enterPassword(String password) async {
    final passwordField = find.byKey(ValueKey(LoginViewKeys.passwordTextField));
    await tester.enterText(passwordField, password);
    await tester.pump();
  }

  Future<void> tapSubmitLoginButton() async {
    final loginButton = find.byKey(ValueKey(LoginViewKeys.loginSubmitButton));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
  }

  void assertLoginViewRendersCorrectly() {
    expect(
      find.byKey(ValueKey(LoginViewKeys.emailTextField)),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey(LoginViewKeys.passwordTextField)),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey(LoginViewKeys.loginSubmitButton)),
      findsOneWidget,
    );
  }

  void assertLoginSuccesful() {
    expect(find.byType(CounterPage), findsOneWidget);
  }

  void assertLoginError() {
    expect(find.text('Login failed'), findsOneWidget);
  }
}
