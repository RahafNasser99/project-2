import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/data/models/comment_model.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/repositories/comments_repository.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/data/data_sources/remote_data_sources/comments_remote_data_source.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  CommentRemoteDataSource commentsRemoteDataSource =
      CommentRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<Comment>>> getComments() async {
    if (await internetConnectionChecker.hasConnection) {
      print('has connection');

      try {
        final comments = await commentsRemoteDataSource.getComments();
        return Right(comments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addComment(Comment comment) async {
    if (await internetConnectionChecker.hasConnection) {
      print('has connection');
      try {
        final commentModel = CommentModel(
          text: comment.text,
          commentDate: comment.commentDate,
        );
        await commentsRemoteDataSource.addComment(commentModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editComments(Comment comment) async {
    if (await internetConnectionChecker.hasConnection) {
      print('has connection');
      try {
        final commentModel = CommentModel(
          text: comment.text,
          commentDate: comment.commentDate,
        );
        await commentsRemoteDataSource.editComment(commentModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteComments(int commentId) async {
    if (await internetConnectionChecker.hasConnection) {
      print('has connection');
      try {
        await commentsRemoteDataSource.deleteComment(commentId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
