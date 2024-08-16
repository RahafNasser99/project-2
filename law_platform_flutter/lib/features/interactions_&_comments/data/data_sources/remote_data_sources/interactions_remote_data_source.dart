import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

abstract class InteractionsRemoteDataSource {
  Future<Unit> addInteraction(bool interaction, int postId);
  Future<Unit> removeInteraction(bool interaction, int postId);
}

class InteractionsRemoteDataSourceImpl extends InteractionsRemoteDataSource {
  @override
  Future<Unit> addInteraction(bool interaction, int postId) async {
    final url =
        interaction ? '/api/post/$postId/like' : '/api/post/$postId/dislike';

    final data = {
      'post_id': postId,
    };

    final response = await dio.post(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${checkAuthentication.getToken()}'
        },
      ),
      data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> removeInteraction(bool interaction, int postId) async {
    final url = interaction
        ? '/api/post/$postId/unlike'
        : '/api/post/$postId/undislike';

    final data = {};

    final response = await dio.post(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${checkAuthentication.getToken()}'
        },
      ),
      data: data,
    );


    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
