import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:post_repository/post_repository.dart';

import 'robots/comment_details_robot.dart';
import 'robots/comments_robot.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late PostRepository postRepository;
  late CommentsRobot commentsRobot;
  late CommentDetailsRobot commentDetailsRobot;

  void setUpCommentsPage() {
    when(() => postRepository.fetchComments(
          postId: any(named: 'postId'),
          limit: any(named: 'limit'),
          page: any(named: 'page'),
        )).thenAnswer((_) async {
      await Future.delayed(Duration(milliseconds: 500));
      return List.generate(
        10,
        (index) => Comment(
          id: index,
          postId: index,
          name: 'name',
          email: 'email',
          body: 'body',
        ),
      );
    });
  }

  void setUpCommentDetails() {
    when(() => postRepository.fetchComment(
          any<int>(),
        )).thenAnswer(
      (_) async => Comment(
        id: 1,
        postId: 2,
        name: 'name',
        email: 'email',
        body: 'body',
      ),
    );
  }

  setUp(() {
    postRepository = MockPostRepository();
  });

  group('CommentsPage', () {
    testWidgets(
      'shows loading spinner when list reaches the end',
      (tester) async {
        commentsRobot = CommentsRobot(tester: tester);

        setUpCommentsPage();

        await commentsRobot.show(postRepository);
        await commentsRobot.swipeUp();
        commentsRobot.assertLoadingIndicator();
      },
    );

    testWidgets(
      'can open [CommentDetailsPage] and like the comment',
      (tester) async {
        commentsRobot = CommentsRobot(tester: tester);
        commentDetailsRobot = CommentDetailsRobot(tester: tester);

        setUpCommentsPage();
        setUpCommentDetails();

        await commentsRobot.show(postRepository);
        await commentsRobot.tapOnComment(0);
        commentDetailsRobot.assertCommentNotLiked();
        await commentDetailsRobot.tapLikeButton();
        commentDetailsRobot.assertCommentLiked();
      },
    );
  });
}
