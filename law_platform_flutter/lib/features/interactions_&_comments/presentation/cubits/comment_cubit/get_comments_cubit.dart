import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/usecases/get_all_comments_usecase.dart';

part 'get_comments_state.dart';

class GetCommentsCubit extends Cubit<GetCommentsState> {
  GetAllCommentsUseCase getAllCommentsUseCase = GetAllCommentsUseCase();
  GetCommentsCubit() : super(GetCommentsInitial());

  Future<void> getAllComments(bool postOrAdvice, int postId) async {
    emit(GetCommentsLoading());

    final either = await getAllCommentsUseCase(postOrAdvice, postId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const GetCommentsError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const GetCommentsError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const GetCommentsError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (comments) {
        if (comments.isEmpty) {
          emit(GetCommentsIsEmpty());
        } else {
          emit(GetCommentsDone(comments: comments));
        }
      },
    );
  }
}
