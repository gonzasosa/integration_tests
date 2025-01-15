part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isError => this == LoginStatus.error;
}

final class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    required this.status,
  });

  const LoginState.initial()
      : this(
          email: '',
          password: '',
          status: LoginStatus.initial,
        );

  final String email;
  final String password;
  final LoginStatus status;

  @override
  List<Object?> get props => [email, password, status];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
