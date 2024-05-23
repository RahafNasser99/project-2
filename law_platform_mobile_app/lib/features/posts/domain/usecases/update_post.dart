import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/posts/domain/entities/post.dart';
import 'package:law_platform_mobile_app/features/posts/domain/repositories/post_repository.dart';
import 'package:law_platform_mobile_app/features/posts/data/repositories_impl/post_repository_impl.dart';

class UpdatePostUseCase {
  PostRepository postRepository = PostRepositoryImpl();

  Future<Either<Failure, Unit>> call(Post post) async {
    print('update post use case');
    return await postRepository.updatePost(post);
  }
}
