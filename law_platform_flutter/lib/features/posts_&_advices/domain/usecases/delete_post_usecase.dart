import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/repositories/post_repository.dart';
import 'package:law_platform_flutter/features/posts_&_advices/data/repositories_impl/post_repository_impl.dart';

class DeletePostUseCase {
  PostRepository postRepository = PostRepositoryImpl();

  // true for posts, false for advice
  Future<Either<Failure, Unit>> call(int postId,bool postOrAdvice) async {
    print('delete post use case');
    return await postRepository.deletePost(postId,postOrAdvice);
  }
}
