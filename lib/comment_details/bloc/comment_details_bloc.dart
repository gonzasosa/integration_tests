import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

part 'comment_details_event.dart';
part 'comment_details_state.dart';

class CommentDetailsBloc
    extends Bloc<CommentDetailsEvent, CommentDetailsState> {
  CommentDetailsBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(const CommentDetailsState.initial()) {
    on<CommentDetailsLoaded>(_onCommentDetailsLoaded);
    on<CommentDetailsLikeToggled>(_onCommentDetailsLikeToggled);
  }

  final PostRepository _postRepository;

  Future<void> _onCommentDetailsLoaded(
    CommentDetailsLoaded event,
    Emitter<CommentDetailsState> emit,
  ) async {
    emit(state.copyWith(status: CommentDetailsStatus.loading));
    try {
      final comment = await _postRepository.fetchComment(event.id);
      emit(
        state.copyWith(
          comment: comment,
          status: CommentDetailsStatus.loaded,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CommentDetailsStatus.error));
    }
  }

  void _onCommentDetailsLikeToggled(
    CommentDetailsLikeToggled event,
    Emitter<CommentDetailsState> emit,
  ) {
    emit(state.copyWith(like: !state.like));
  }
}
