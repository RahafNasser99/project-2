import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, Map<String,dynamic>>> getPosts(int pageNumber);
  Future<Either<Failure, Unit>> addPost(String postBody,String? imagePath,String? imageName);
  Future<Either<Failure, Unit>> updatePost(String postId,String postBody,String? imagePath,String? imageName);
  Future<Either<Failure, Unit>> deletePost(int postId);
}
