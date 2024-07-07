import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/repositories/post_repository.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/data/repositories_impl/post_repository_impl.dart';

class UpdatePostUseCase {
  PostRepository postRepository = PostRepositoryImpl();

  Future<Either<Failure, Unit>> call(String postId, String postBody,
      String? imagePath, String? imageName) async {
    print('update post use case');
    return await postRepository.updatePost(
        postId, postBody, imagePath, imageName);
  }
}
