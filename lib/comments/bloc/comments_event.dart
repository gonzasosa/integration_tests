part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {}

class CommentsLoaded extends CommentsEvent {
  CommentsLoaded();

  @override
  List<Object?> get props => [];
}
