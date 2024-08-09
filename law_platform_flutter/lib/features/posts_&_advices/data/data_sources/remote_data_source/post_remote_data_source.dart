import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/global_classes/check_authentication.dart';
import 'package:law_platform_flutter/features/posts_&_advices/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<Map<String, dynamic>> getPosts(
      int pageNumber, bool postOrAdvice); // true for posts, false for advice
  Future<Unit> addPost(
      String postBody, String? imagePath, String? imageName, bool postOrAdvice);
  Future<Unit> updatePost(String postId, String postBody, String? imagePath,
      String? imageName, bool postOrAdvice);
  Future<Unit> deletePost(int postId, bool postOrAdvice);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  CheckAuthentication checkAuthentication = CheckAuthentication();
  @override
  Future<Map<String, dynamic>> getPosts(
      int pageNumber, bool postOrAdvice) async {
    final url = postOrAdvice
        ? '/api/post/all?per_page=6&page=$pageNumber'
        : '/api/legalAdvice/all?per_page=6&page=$pageNumber';

    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${checkAuthentication.getToken()}'
        },
      ),
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      final totalPages = response.data['pagination']['total_pages'];
      final List decodedJson = response.data['data'] as List;
      final List<PostModel> postModels = decodedJson
          .map((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      Map<String, dynamic> returnedPosts = {
        'posts': postModels,
        'totalPages': totalPages,
      };
      return returnedPosts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(String postBody, String? imagePath, String? imageName,
      bool postOrAdvice) async {
    final url = postOrAdvice ? '/api/post/create' : '/api/legalAdvice/create';

    MultipartFile? multipartFile = (imagePath != null)
        ? await MultipartFile.fromFile(imagePath, filename: imageName)
        : null;

    FormData formData = postOrAdvice
        ? FormData.fromMap({
            'text': postBody,
            'image': multipartFile,
          })
        : FormData.fromMap({
            'advice_type_id': 1,
            'text': postBody,
            'image': multipartFile,
          });

    final response = await dio.post(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${checkAuthentication.getToken()}'
        },
      ),
      data: formData,
    );

    print(response.data);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(String postId, String postBody, String? imagePath,
      String? imageName, bool postOrAdvice) async {
    final url = postOrAdvice ? '/api/post/update/$postId' : '';

    // final data = postModel.toJson();

    final response = await dio.post(
      url,
      // data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId, bool postOrAdvice) async {
    final url = postOrAdvice ? '' : '';
    print('delete post');

    final data = {
      'id': postId,
    };

    final response = await dio.post(
      url,
      data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
