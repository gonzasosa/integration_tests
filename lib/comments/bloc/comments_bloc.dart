import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(CommentsState.initial()) {
    on<CommentsLoaded>(_onCommentsLoaded);
  }

  static const _limit = 10;

  final PostRepository _postRepository;

  Future<void> _onCommentsLoaded(
    CommentsLoaded event,
    Emitter<CommentsState> emit,
  ) async {
    if (state.hasReachedMax || state.status.isLoading) return;
    try {
      emit(state.copyWith(status: CommentsStatus.loading));
      final comments = await _postRepository.fetchComments(
        postId: 1,
        limit: _limit,
        page: state.page,
      );
      emit(
        state.copyWith(
          hasReachedMax: comments.isEmpty,
          comments: [...state.comments, ...comments],
          status: CommentsStatus.success,
          page: state.page + 1,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CommentsStatus.failure));
    }
  }
}
