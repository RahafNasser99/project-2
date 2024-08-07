import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, Map<String,dynamic>>> getPosts(int pageNumber,bool postOrAdvice);  // true for posts, false for advice
  Future<Either<Failure, Unit>> addPost(String postBody,String? imagePath,String? imageName,bool postOrAdvice);
  Future<Either<Failure, Unit>> updatePost(String postId,String postBody,String? imagePath,String? imageName,bool postOrAdvice);
  Future<Either<Failure, Unit>> deletePost(int postId,bool postOrAdvice);
}
