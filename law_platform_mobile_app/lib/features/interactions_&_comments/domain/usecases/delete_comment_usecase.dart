import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/repositories/comments_repository.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/data/repositories_impl/comments_repository_impl.dart';

class DeleteCommentUseCase {
  CommentsRepository commentsRepository = CommentsRepositoryImpl();

  Future<Either<Failure, Unit>> call(int commentId) async {
    print('delete comment use case');
    return await commentsRepository.deleteComments(commentId);
  }
}
