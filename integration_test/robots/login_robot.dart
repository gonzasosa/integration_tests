import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tests/home/home.dart';
import 'package:integration_tests/login/login.dart';

class LoginRobot {
  LoginRobot({
    required this.tester,
  });

  final WidgetTester tester;

  Future<void> show(AuthRepository authRepository) async {
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
    expect(find.byType(HomePage), findsOneWidget);
  }

  void assertLoginError() {
    expect(find.text('Login failed'), findsOneWidget);
  }
}
