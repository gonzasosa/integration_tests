import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_tests/comments/comments.dart';
import 'package:post_repository/post_repository.dart';

class CommentsRobot {
  CommentsRobot({required this.tester});

  final WidgetTester tester;

  Future<void> show(PostRepository postRepository) async {
    await tester.pumpWidget(
      RepositoryProvider.value(
        value: postRepository,
        child: MaterialApp(home: CommentsPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> swipeUp() async {
    await tester.drag(find.byType(ListView), const Offset(0, -2000));
    await tester.pump();
  }

  void assertLoadingIndicator() {
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  Future<void> tapOnComment(int index) async {
    await tester.tap(find.byKey(ValueKey(index)));
    await tester.pumpAndSettle();
  }
}
