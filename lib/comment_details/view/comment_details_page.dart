import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_tests/comment_details/comment_details.dart';
import 'package:post_repository/post_repository.dart';

class CommentDetailsPage extends StatelessWidget {
  const CommentDetailsPage({
    super.key,
    required this.id,
  });

  final int id;

  static Route<void> route(int id) {
    return MaterialPageRoute(
      builder: (context) {
        return CommentDetailsPage(id: id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentDetailsBloc(
        postRepository: context.read<PostRepository>(),
      )..add(CommentDetailsLoaded(id)),
      child: const CommentDetailsView(),
    );
  }
}
