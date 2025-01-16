import 'dart:math';

import 'package:post_repository/post_repository.dart';
import 'package:post_repository/src/data/posts_data.dart';

/// {@template post_repository}
/// Provides an abstraction to access the Posts domain.
/// {@endtemplate}
class PostRepository {
  /// {@macro post_repository}
  const PostRepository();

  /// Returns a list of [Comment]s for the given [postId].
  ///
  /// The [page] parameter is used to paginate the results and it is 1-based.
  ///
  /// The [limit] parameter is used to define the number of items per page.
  Future<List<Comment>> fetchComments({
    required int postId,
    required int page,
    required int limit,
  }) async {
    final start = (page - 1) * limit;
    final end = min(start + limit, postsData.length);
    final items = postsData.sublist(start, end);
    final response = <Comment>[];
    for (final item in items) {
      response.add(
        Comment(
          id: item['id']! as int,
          postId: item['postId']! as int,
          name: item['name']! as String,
          email: item['email']! as String,
          body: item['body']! as String,
        ),
      );
    }
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return response;
  }

  /// Returns a [Comment] for the given [id].
  Future<Comment> fetchComment(int id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final item = postsData.first as Map<String, dynamic>;
    return Comment(
      id: item['id']! as int,
      postId: item['postId']! as int,
      name: item['name']! as String,
      email: item['email']! as String,
      body: item['body']! as String,
    );
  }
}
