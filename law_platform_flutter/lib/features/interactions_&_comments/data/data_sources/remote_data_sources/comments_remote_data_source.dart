import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments(bool postOrAdvice, int postId);
  Future<Unit> addComment(
      CommentModel commentModel, bool postOrAdvice, int postId);
  Future<Unit> editComment(CommentModel commentModel, bool postOrAdvice);
  Future<Unit> deleteComment(int commentId, bool postOrAdvice);
}

class CommentRemoteDataSourceImpl extends CommentRemoteDataSource {
  @override
  Future<List<CommentModel>> getComments(bool postOrAdvice, int postId) async {
    print(postOrAdvice);
    print(postId);
    final url = postOrAdvice
        ? '/api/post/$postId/allComments'
        : '/api/legalAdvice/$postId/allComments';

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
      final List decodedJson = response.data['data'] as List;
      final List<CommentModel> commentModels = decodedJson
          .map((jsonCommentModel) => CommentModel.fromJson(jsonCommentModel))
          .toList();

      return commentModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addComment(
      CommentModel commentModel, bool postOrAdvice, int postId) async {
    final url = postOrAdvice
        ? '/api/post/$postId/createComment'
        : '/api/legalAdvice/$postId/createComment';

    final data = postOrAdvice
        ? {'content': commentModel.text}
        : {'comment': commentModel.text};

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
  Future<Unit> deleteComment(int commentId, bool postOrAdvice) async {
    final url = postOrAdvice
        ? '/api/post/deleteComment/$commentId'
        : '/api/legalAdvice/deleteComment/$commentId';

    final data = {'commentId': commentId};

    final response = await dio.delete(
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
  Future<Unit> editComment(CommentModel commentModel, bool postOrAdvice) async {
    final url = postOrAdvice
        ? '/api/post/updateComment/${commentModel.commentId}'
        : '/api/legalAdvice/updateComment/${commentModel.commentId}';

    final data = postOrAdvice
        ? {'content': commentModel.text}
        : {'comment': commentModel.text};

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
