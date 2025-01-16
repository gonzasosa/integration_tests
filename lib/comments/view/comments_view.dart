import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_tests/comment_details/comment_details.dart';
import 'package:integration_tests/comments/comments.dart';
import 'package:post_repository/post_repository.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((CommentsBloc bloc) => bloc.state.status);
    final comments = context.select((CommentsBloc bloc) => bloc.state.comments);
    late final Widget body;

    switch (status) {
      case CommentsStatus.initial:
        body = CircularProgressIndicator.adaptive();
        break;
      case CommentsStatus.loading:
        if (comments.isEmpty) {
          body = CircularProgressIndicator.adaptive();
        } else {
          body = CommentsListView();
        }
        break;
      case CommentsStatus.success:
        body = CommentsListView();
        break;
      case CommentsStatus.failure:
        body = Text('Something went wrong!');
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Center(child: body),
    );
  }
}

class CommentsListView extends StatelessWidget {
  const CommentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final comments = context.select((CommentsBloc bloc) => bloc.state.comments);
    final hasReachedMax = context.select(
      (CommentsBloc bloc) => bloc.state.hasReachedMax,
    );
    return ListView.builder(
      shrinkWrap: true,
      itemCount: hasReachedMax ? comments.length : comments.length + 1,
      itemBuilder: (context, index) {
        if (index >= comments.length && !hasReachedMax) {
          context.read<CommentsBloc>().add(CommentsLoaded());
          return const BottomLoader();
        } else {
          return CommentListTile(
            index: index,
            comment: comments[index],
          );
        }
      },
    );
  }
}

class CommentListTile extends StatelessWidget {
  const CommentListTile({
    super.key,
    required this.index,
    required this.comment,
  });

  final int index;
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(index),
      onTap: () {
        Navigator.of(context).push(CommentDetailsPage.route(comment.id));
      },
      leading: Text(index.toString()),
      title: Text(comment.name),
      subtitle: Text(comment.body),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
