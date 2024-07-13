import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/global_classes/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/repositories/post_repository.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/data/data_sources/remote_data_source/post_remote_data_source.dart';

class PostRepositoryImpl extends PostRepository {
  PostRemoteDataSource postRemoteDataSource = PostRemoteDataSourceImpl();

  @override
  Future<Either<Failure, Map<String,dynamic>>> getPosts(int pageNumber) async {
    if (await internetConnectionChecker.hasConnection) {
      print('has connection');

      try {
        final returnedPosts = await postRemoteDataSource.getPosts(pageNumber);
        return Right(returnedPosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(
      String postBody, String? imagePath, String? imageName) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await postRemoteDataSource.addPost(postBody, imagePath, imageName);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(String postId, String postBody,
      String? imagePath, String? imageName) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await postRemoteDataSource.updatePost(
          postId,
          postBody,
          imagePath,
          imageName,
        );
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await postRemoteDataSource.deletePost(postId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
