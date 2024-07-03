import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/repositories/post_repository.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/data/repositories_impl/post_repository_impl.dart';

class DeletePostUseCase {
  PostRepository postRepository = PostRepositoryImpl();

  Future<Either<Failure, Unit>> call(int postId) async {
    print('delete post use case');
    return await postRepository.deletePost(postId);
  }
}
