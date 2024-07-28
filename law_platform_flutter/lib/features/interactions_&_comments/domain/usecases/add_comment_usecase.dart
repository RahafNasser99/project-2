import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/repositories/comments_repository.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/repositories_impl/comments_repository_impl.dart';

class AddCommentUseCase {
  CommentsRepository commentsRepository = CommentsRepositoryImpl();

  Future<Either<Failure, Unit>> call(Comment comment) async {
    print('add comment use case');
    return await commentsRepository.addComment(comment);
  }
}
