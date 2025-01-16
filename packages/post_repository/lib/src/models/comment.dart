import 'package:equatable/equatable.dart';

/// {@template comment}
/// Represents a Post comment.
/// {@endtemplate}
class Comment extends Equatable {
  /// {@macro comment}
  const Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  /// The comment identifier.
  final int id;

  /// The post identifier this comment belongs to.
  final int postId;

  /// The comment name.
  final String name;

  /// The email address of the creator of this comment.
  final String email;

  /// The comment body.
  final String body;

  @override
  List<Object?> get props => [
        id,
        postId,
        name,
        email,
        body,
      ];
}
