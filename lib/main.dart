import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_tests/login/login.dart';
import 'package:post_repository/post_repository.dart';

void main() {
  runApp(
    App(
      count: 0,
      authRepository: AuthRepository(),
      postRepository: PostRepository(),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.count,
    required AuthRepository authRepository,
    required PostRepository postRepository,
  })  : _authRepository = authRepository,
        _postRepository = postRepository;

  final int count;
  final AuthRepository _authRepository;
  final PostRepository _postRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authRepository,
        ),
        RepositoryProvider.value(
          value: _postRepository,
        ),
      ],
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
