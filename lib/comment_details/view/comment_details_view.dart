import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_tests/comment_details/comment_details.dart';

class CommentDetailsKeys {
  static const likeButton = ValueKey('likeButton');
  static const favoriteIcon = ValueKey('favoriteIcon');
  static const favoriteRoundedIcon = ValueKey('favoriteRoundedIcon');
}

class CommentDetailsView extends StatelessWidget {
  const CommentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (CommentDetailsBloc bloc) => bloc.state.status,
    );

    switch (status) {
      case CommentDetailsStatus.initial:
      case CommentDetailsStatus.loading:
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );

      case CommentDetailsStatus.error:
        return Center(
          child: Text('Error: Something went wrong.'),
        );
      case CommentDetailsStatus.loaded:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Comment Details'),
          ),
          body: CommentDetails(),
        );
    }
  }
}

class CommentDetails extends StatelessWidget {
  const CommentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final comment = context.select(
      (CommentDetailsBloc bloc) => bloc.state.comment,
    );
    if (comment == null) return const SizedBox();

    return Column(
      children: [
        Text(comment.email),
        SizedBox(
          height: 24,
        ),
        Text(comment.name),
        SizedBox(
          height: 24,
        ),
        Text(comment.body),
        SizedBox(
          height: 24,
        ),
        CommentLikeButton(),
      ],
    );
  }
}

class CommentLikeButton extends StatelessWidget {
  const CommentLikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final like = context.select((CommentDetailsBloc bloc) => bloc.state.like);
    return IconButton(
      key: CommentDetailsKeys.likeButton,
      onPressed: () {
        context.read<CommentDetailsBloc>().add(CommentDetailsLikeToggled());
      },
      icon: Icon(
        key: like
            ? CommentDetailsKeys.favoriteIcon
            : CommentDetailsKeys.favoriteRoundedIcon,
        like ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}
