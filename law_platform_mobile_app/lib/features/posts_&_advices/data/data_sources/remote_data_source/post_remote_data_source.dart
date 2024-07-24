import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/global_classes/configurations.dart';
import 'package:law_platform_mobile_app/utils/global_classes/check_authentication.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<Map<String, dynamic>> getPosts(int pageNumber);
  Future<Unit> addPost(String postBody, String? imagePath, String? imageName);
  Future<Unit> updatePost(
      String postId, String postBody, String? imagePath, String? imageName);
  Future<Unit> deletePost(int postId);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  CheckAuthentication checkAuthentication = CheckAuthentication();
  @override
  Future<Map<String, dynamic>> getPosts(int pageNumber) async {
    const url = '/api/post/all?per_page=10';

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
  Future<Unit> addPost(
      String postBody, String? imagePath, String? imageName) async {
    const url = '/api/post/create';

    MultipartFile? multipartFile = (imagePath != null)
        ? await MultipartFile.fromFile(imagePath, filename: imageName)
        : null;

    FormData formData = FormData.fromMap({
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
      String? imageName) async {
    final url = '/api/post/update/$postId';

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
  Future<Unit> deletePost(int postId) async {
    const url = '';
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
