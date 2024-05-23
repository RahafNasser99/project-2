import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/posts/domain/entities/post.dart';
import 'package:law_platform_mobile_app/features/posts/data/models/post_model.dart';
import 'package:law_platform_mobile_app/features/posts/domain/repositories/post_repository.dart';
import 'package:law_platform_mobile_app/features/posts/data/data_sources/remote_data_source/post_remote_data_source.dart';

class PostRepositoryImpl extends PostRepository {
  PostRemoteDataSource postRemoteDataSource = PostRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await internetConnectionChecker.hasConnection) {
      print('has connection');

      try {
        final posts = await postRemoteDataSource.getPosts();
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModel postModel = PostModel(
      postId: post.postId,
      postBody: post.postBody,
      postImage: post.postImage,
      postDate: post.postDate,
    );

    if (await internetConnectionChecker.hasConnection) {
      try {
        await postRemoteDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel = PostModel(
      postId: post.postId,
      postBody: post.postBody,
      postImage: post.postImage,
      postDate: post.postDate,
    );

    if (await internetConnectionChecker.hasConnection) {
      try {
        await postRemoteDataSource.updatePost(postModel);
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
