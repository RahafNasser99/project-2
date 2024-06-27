import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/usecases/add_post.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/usecases/update_post.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/usecases/delete_post.dart';

part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostCubit extends Cubit<AddUpdateDeletePostState> {
  AddPostUseCase addPostUseCase = AddPostUseCase();
  UpdatePostUseCase updatePostUseCase = UpdatePostUseCase();
  DeletePostUseCase deletePostUseCase = DeletePostUseCase();

  AddUpdateDeletePostCubit() : super(AddUpdateDeletePostInitial());

  Future<void> addUpdatePost(String addOrUpdate, Post post) async {
    emit(AddUpdateDeletePostLoading());

    final Either<Failure, Unit> either;

    if (addOrUpdate == 'add') {
      either = await addPostUseCase(post);
    } else {
      either = await updatePostUseCase(post);
    }

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return const AddUpdateDeletePostError(
                errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const AddUpdateDeletePostError(
                errorMessage: OFFLINE_SERVER_MESSAGE);
          default:
            return const AddUpdateDeletePostError(
                errorMessage: DEFAULT_FAILURE_MESSAGE);
        }
      },
      (_) => AddUpdateDeletePostDone(),
    );
  }

  Future<void> deletePost(int postId) async {
    emit(AddUpdateDeletePostLoading());
    final either = await deletePostUseCase(postId);

    either.fold((failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return const AddUpdateDeletePostError(
              errorMessage: SERVER_FAILURE_MESSAGE);
        case OfflineFailure:
          return const AddUpdateDeletePostError(
              errorMessage: OFFLINE_SERVER_MESSAGE);
        default:
          return const AddUpdateDeletePostError(
              errorMessage: DEFAULT_FAILURE_MESSAGE);
      }
    }, (_) => AddUpdateDeletePostDone());
  }
}
