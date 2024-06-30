import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comment>>> getComments();
  Future<Either<Failure, Unit>> addComment(Comment comment);
  Future<Either<Failure, Unit>> editComments(Comment comment);
  Future<Either<Failure, Unit>> deleteComments(int commentId);
}
