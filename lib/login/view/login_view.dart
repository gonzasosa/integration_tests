import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_tests/home/home.dart';
import 'package:integration_tests/login/login.dart';

abstract class LoginViewKeys {
  static const emailTextField = 'loginEmailTextField';
  static const passwordTextField = 'loginPasswordTextField';
  static const loginSubmitButton = 'loginSubmitButton';
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pushReplacement(HomePage.route());
        } else if (state.status.isError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Login failed')),
            );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _EmailTextField(),
              SizedBox(height: 8),
              _PasswordTextField(),
              SizedBox(height: 8),
              _LoginSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: ValueKey(LoginViewKeys.emailTextField),
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: ValueKey(LoginViewKeys.passwordTextField),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
    );
  }
}

class _LoginSubmitButton extends StatelessWidget {
  const _LoginSubmitButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: ValueKey(LoginViewKeys.loginSubmitButton),
      onPressed: () {
        context.read<LoginBloc>().add(LoginSubmitted());
      },
      child: Text('Log in'),
    );
  }
}
