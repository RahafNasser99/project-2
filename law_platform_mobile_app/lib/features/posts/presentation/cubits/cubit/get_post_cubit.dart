import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/posts/domain/entities/post.dart';
import 'package:law_platform_mobile_app/features/posts/domain/usecases/get_posts.dart';

part 'get_post_state.dart';

class GetPostCubit extends Cubit<GetPostState> {
  GetPostsUseCase getPostsUseCase = GetPostsUseCase();
  GetPostCubit() : super(GetPostInitial());

  Future<void> getPosts() async {
    emit(GetPostLoading());

    final either = await getPostsUseCase();

    either.fold((failure) {
      print(failure.toString());
      switch (failure.runtimeType) {
        case ServerFailure:
          return const GetPostError(errorMessage: SERVER_FAILURE_MESSAGE);
        case OfflineFailure:
          return const GetPostError(errorMessage: OFFLINE_SERVER_MESSAGE);
        default:
          return const GetPostError(errorMessage: DEFAULT_FAILURE_MESSAGE);
      }
    }, (posts) => GetPostDone(posts: posts));
  }
}
