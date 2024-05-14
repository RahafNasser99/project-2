import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/constant.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/posts/domain/entities/post.dart';
import 'package:law_platform_mobile_app/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int postId);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  @override
  Future<List<Post>> getPosts() async {
    const url = '';
    print('get data');

    final response = await dio.get(url);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      final List decodedJson = json.decode(response.data) as List;
      final List<PostModel> postModels = decodedJson
          .map((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    const url = '';
    
    print('add post');

    final data = postModel.toJson();

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

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    const url = '';
    print('update post');

    final data = postModel.toJson();

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

  @override
  Future<Unit> deletePost(int  postId) async {
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
