import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/repositories/post_repository.dart';
import 'package:law_platform_flutter/features/posts_&_advices/data/repositories_impl/post_repository_impl.dart';

class GetPostsUseCase {
  PostRepository postRepository = PostRepositoryImpl();

  Future<Either<Failure, Map<String,dynamic>>> call(int pageNumber) async {
    print('get posts use case');
    return await postRepository.getPosts(pageNumber);
  }
}
