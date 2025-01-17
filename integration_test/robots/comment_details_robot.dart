import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tests/comment_details/comment_details.dart';
import 'package:post_repository/post_repository.dart';

class CommentDetailsRobot {
  CommentDetailsRobot({required this.tester});

  final WidgetTester tester;

  Future<void> show(PostRepository postRepository) async {
    await tester.pumpWidget(
      RepositoryProvider.value(
        value: postRepository,
        child: MaterialApp(home: CommentDetailsPage(id: 1)),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapLikeButton() async {
    await tester.tap(find.byKey(CommentDetailsKeys.likeButton));
    await tester.pumpAndSettle();
  }

  void assertCommentLiked() {
    expect(find.byKey(CommentDetailsKeys.favoriteIcon), findsOneWidget);
  }

  void assertCommentNotLiked() {
    expect(find.byKey(CommentDetailsKeys.favoriteRoundedIcon), findsOneWidget);
  }
}
