import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/usecases/get_posts_usecase.dart';

part 'get_post_state.dart';

class GetPostCubit extends Cubit<GetPostState> {
  GetPostsUseCase getPostsUseCase = GetPostsUseCase();
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  int pageNumber = 0;
  int pageCount = 0;

  GetPostCubit() : super(GetPostInitial()) {
    scrollController.addListener(() async {
      await getMorePosts().then((_) => isLoadingMore = false);
    });
  }

  Future<void> getPosts() async {
    pageNumber = 0;

    emit(GetPostLoading());

    final either = await getPostsUseCase(pageNumber);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const GetPostError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const GetPostError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const GetPostError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (returnedPosts) {
        if ((returnedPosts['posts'] as List).isEmpty) {
          emit(GetPostIsEmpty());
        } else {
          emit(GetPostDone(
              pageCount: returnedPosts['totalPages'],
              posts: returnedPosts['posts']));
        }
      },
    );
  }

  Future<void> getMorePosts() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        pageNumber < pageCount) {
      isLoadingMore = true;
      pageNumber++;

      final either = await getPostsUseCase(pageNumber);

      either.fold(
        (failure) {
          pageNumber--;
          switch (failure.runtimeType) {
            case ServerFailure:
              emit(const GetPostError(errorMessage: SERVER_FAILURE_MESSAGE));
            case OfflineFailure:
              emit(const GetPostError(errorMessage: OFFLINE_SERVER_MESSAGE));
            default:
              emit(const GetPostError(errorMessage: DEFAULT_FAILURE_MESSAGE));
          }
        },
        (returnedPosts) => emit(GetPostDone(
            pageCount: returnedPosts['totalPages'],
            posts: returnedPosts['posts'])),
      );
    }
  }
}
