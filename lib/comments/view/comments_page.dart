import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_tests/comments/comments.dart';
import 'package:post_repository/post_repository.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsBloc(
        postRepository: context.read<PostRepository>(),
      )..add(CommentsLoaded()),
      child: const CommentsView(),
    );
  }
}
