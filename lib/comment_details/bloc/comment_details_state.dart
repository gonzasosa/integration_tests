part of 'comment_details_bloc.dart';

enum CommentDetailsStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == CommentDetailsStatus.initial;
  bool get isLoading => this == CommentDetailsStatus.loading;
  bool get isLoaded => this == CommentDetailsStatus.loaded;
  bool get isError => this == CommentDetailsStatus.error;
}

class CommentDetailsState extends Equatable {
  const CommentDetailsState({
    required this.status,
    required this.like,
    this.comment,
  });

  const CommentDetailsState.initial()
      : this(
          like: false,
          status: CommentDetailsStatus.initial,
        );

  final Comment? comment;
  final bool like;
  final CommentDetailsStatus status;

  @override
  List<Object?> get props => [comment, like, status];

  CommentDetailsState copyWith({
    Comment? comment,
    bool? like,
    CommentDetailsStatus? status,
  }) {
    return CommentDetailsState(
      comment: comment ?? this.comment,
      like: like ?? this.like,
      status: status ?? this.status,
    );
  }
}
