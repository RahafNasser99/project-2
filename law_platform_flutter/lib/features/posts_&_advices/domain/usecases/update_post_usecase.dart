import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/repositories/post_repository.dart';
import 'package:law_platform_flutter/features/posts_&_advices/data/repositories_impl/post_repository_impl.dart';

class UpdatePostUseCase {
  PostRepository postRepository = PostRepositoryImpl();

  // true for posts, false for advice
  Future<Either<Failure, Unit>> call(String postId, String postBody,
      String? imagePath, String? imageName,bool postOrAdvice) async {
    print('update post use case');
    return await postRepository.updatePost(
        postId, postBody, imagePath, imageName,postOrAdvice);
  }
}
