import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments();
  Future<Unit> addComment(CommentModel commentModel);
  Future<Unit> editComment(CommentModel commentModel);
  Future<Unit> deleteComment(int commentId);
}

class CommentRemoteDataSourceImpl extends CommentRemoteDataSource {
  @override
  Future<List<CommentModel>> getComments() async {
    const url = '';

    final response = await dio.get(url);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      final List decodedJson = json.decode(response.data) as List;
      final List<CommentModel> commentModels = decodedJson
          .map((jsonCommentModel) => CommentModel.fromJson(jsonCommentModel))
          .toList();

      return commentModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addComment(CommentModel commentModel) async {
    const url = '';

    final data = commentModel.toJson();

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
  Future<Unit> deleteComment(int commentId) async {
    const url = '';

    final data = {'commentId': commentId};

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
  Future<Unit> editComment(CommentModel commentModel) async {
    const url = '';

    final data = commentModel.toJson();

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
