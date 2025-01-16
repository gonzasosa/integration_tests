part of 'comments_bloc.dart';

enum CommentsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == CommentsStatus.initial;
  bool get isLoading => this == CommentsStatus.loading;
  bool get isSuccess => this == CommentsStatus.success;
  bool get isFailure => this == CommentsStatus.failure;
}

class CommentsState extends Equatable {
  const CommentsState({
    required this.comments,
    required this.page,
    required this.hasReachedMax,
    required this.status,
  });

  CommentsState.initial()
      : this(
          comments: [],
          page: 1,
          hasReachedMax: false,
          status: CommentsStatus.initial,
        );

  final List<Comment> comments;
  final int page;
  final bool hasReachedMax;
  final CommentsStatus status;

  @override
  List<Object?> get props => [comments, page, hasReachedMax, status];

  CommentsState copyWith({
    List<Comment>? comments,
    int? page,
    bool? hasReachedMax,
    CommentsStatus? status,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }
}
