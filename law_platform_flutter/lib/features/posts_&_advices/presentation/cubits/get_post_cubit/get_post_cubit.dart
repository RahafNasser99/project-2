// ignore_for_file: type_literal_in_constant_pattern

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/usecases/get_posts_usecase.dart';

part 'get_post_state.dart';

class GetPostCubit extends Cubit<GetPostState> {
  GetPostsUseCase getPostsUseCase = GetPostsUseCase();
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  bool postOrAdviceCubit = true;
  int? userIdCubit;
  int pageNumber = 1;
  int pageCount = 0;

  GetPostCubit() : super(GetPostInitial()) {
    scrollController.addListener(() async {
      await getMorePosts(postOrAdviceCubit, userIdCubit)
          .then((_) => isLoadingMore = false);
    });
  }

  Future<void> getPosts(bool postsOrAdvice, int? userId) async {
    if (!isClosed) {
      // true for posts, false for advice
      pageNumber = 1;
      postOrAdviceCubit = postsOrAdvice;
      userIdCubit = userId;

      emit(GetPostLoading());

      final either = await getPostsUseCase(
        pageNumber,
        postsOrAdvice,
        userId,
      );

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
            pageCount = returnedPosts['totalPages'];
            emit(GetPostDone(
                pageCount: returnedPosts['totalPages'],
                posts: returnedPosts['posts']));
          }
        },
      );
    }
  }

  Future<void> getMorePosts(bool postsOrAdvice, int? userId) async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        pageNumber <= pageCount) {
      isLoadingMore = true;
      pageNumber++;

      final either = await getPostsUseCase(
        pageNumber,
        postsOrAdvice,
        userId,
      );

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
            posts: [
              ...(state as GetPostDone).posts,
              ...returnedPosts['posts']
            ])),
      );
    }
  }
}
