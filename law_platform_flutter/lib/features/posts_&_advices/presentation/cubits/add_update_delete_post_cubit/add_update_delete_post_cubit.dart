import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/usecases/add_post_usecase.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/usecases/update_post_usecase.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/usecases/delete_post_usecase.dart';

part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostCubit extends Cubit<AddUpdateDeletePostState> {
  AddPostUseCase addPostUseCase = AddPostUseCase();
  UpdatePostUseCase updatePostUseCase = UpdatePostUseCase();
  DeletePostUseCase deletePostUseCase = DeletePostUseCase();

  AddUpdateDeletePostCubit() : super(AddUpdateDeletePostInitial());

  Future<void> addUpdatePost(String addOrUpdate, String postId, String postBody,
      String? imagePath, String? imageName) async {
    emit(AddUpdateDeletePostLoading());

    final Either<Failure, Unit> either;

    if (addOrUpdate == 'add') {
      either = await addPostUseCase(postBody, imagePath, imageName);
    } else {
      either = await updatePostUseCase(postId, postBody, imagePath, imageName);
    }

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const AddUpdateDeletePostError(
                errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const AddUpdateDeletePostError(
                errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const AddUpdateDeletePostError(
                errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(AddUpdateDeletePostDone()),
    );
  }

  Future<void> deletePost(int postId) async {
    emit(AddUpdateDeletePostLoading());

    final either = await deletePostUseCase(postId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const AddUpdateDeletePostError(
                errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const AddUpdateDeletePostError(
                errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const AddUpdateDeletePostError(
                errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(AddUpdateDeletePostDone()),
    );
  }
}
