import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/usecases/add_comment.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/usecases/edit_comment.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/usecases/delete_comment.dart';

part 'add_edit_delete_comment_state.dart';

class AddEditDeleteCommentCubit extends Cubit<AddEditDeleteCommentState> {
  AddCommentUseCase addCommentUseCase = AddCommentUseCase();
  EditCommentUseCase editCommentUseCase = EditCommentUseCase();
  DeleteCommentUseCase deleteCommentUseCase = DeleteCommentUseCase();

  AddEditDeleteCommentCubit() : super(AddEditDeleteCommentInitial());

  Future<void> addOrEditComment(String addOrEdit, Comment comment) async {
    emit(AddEditDeleteCommentLoading());

    final either = addOrEdit == 'add'
        ? await addCommentUseCase(comment)
        : await editCommentUseCase(comment);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return const AddEditDeleteCommentError(
                errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const AddEditDeleteCommentError(
                errorMessage: OFFLINE_SERVER_MESSAGE);
          default:
            return const AddEditDeleteCommentError(
                errorMessage: DEFAULT_FAILURE_MESSAGE);
        }
      },
      (_) => AddEditDeleteCommentDone(),
    );
  }

  Future<void> deleteComment(int commentId) async {
    emit(AddEditDeleteCommentLoading());

    final either = await deleteCommentUseCase(commentId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return const AddEditDeleteCommentError(
                errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const AddEditDeleteCommentError(
                errorMessage: OFFLINE_SERVER_MESSAGE);
          default:
            return const AddEditDeleteCommentError(
                errorMessage: DEFAULT_FAILURE_MESSAGE);
        }
      },
      (_) => AddEditDeleteCommentDone(),
    );
  }
}
