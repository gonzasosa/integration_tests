part of 'comment_details_bloc.dart';

abstract class CommentDetailsEvent extends Equatable {
  const CommentDetailsEvent();
}

class CommentDetailsLoaded extends CommentDetailsEvent {
  const CommentDetailsLoaded(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class CommentDetailsLikeToggled extends CommentDetailsEvent {
  const CommentDetailsLikeToggled();

  @override
  List<Object> get props => [];
}
