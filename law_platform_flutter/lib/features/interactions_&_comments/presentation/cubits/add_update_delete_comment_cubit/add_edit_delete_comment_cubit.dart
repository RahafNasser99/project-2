import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/usecases/add_comment_usecase.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/usecases/edit_comment_usecase.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/usecases/delete_comment_usecase.dart';

part 'add_edit_delete_comment_state.dart';

class AddEditDeleteCommentCubit extends Cubit<AddEditDeleteCommentState> {
  AddCommentUseCase addCommentUseCase = AddCommentUseCase();
  EditCommentUseCase editCommentUseCase = EditCommentUseCase();
  DeleteCommentUseCase deleteCommentUseCase = DeleteCommentUseCase();

  AddEditDeleteCommentCubit() : super(AddEditDeleteCommentInitial());

  Future<void> addOrEditComment(
      String addOrEdit, Comment comment, bool postOrAdvice, int postId) async {
    emit(AddEditDeleteCommentLoading());

    final either = addOrEdit == 'add'
        ? await addCommentUseCase(comment, postOrAdvice, postId)
        : await editCommentUseCase(comment, postOrAdvice, postId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const AddEditDeleteCommentError(
                errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const AddEditDeleteCommentError(
                errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const AddEditDeleteCommentError(
                errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(AddEditDeleteCommentDone()),
    );
  }

  Future<void> deleteComment(
      int commentId, bool postOrAdvice, int postId) async {
    emit(AddEditDeleteCommentLoading());

    final either = await deleteCommentUseCase(commentId, postOrAdvice, postId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const AddEditDeleteCommentError(
                errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const AddEditDeleteCommentError(
                errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const AddEditDeleteCommentError(
                errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(AddEditDeleteCommentDone()),
    );
  }
}
