import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/messaging/domain/entities/message.dart';
import 'package:law_platform_flutter/features/messaging/data/models/message_model.dart';

abstract class MessagingRemoteDataSource {
  Future<List<Message>> getMessages();
  Future<Unit> addMessage(MessageModel messageModel);
  Future<Unit> editMessage(MessageModel messageModel);
  Future<Unit> deleteMessage(int messageId);
}

class MessagingRemoteDataSourceImpl extends MessagingRemoteDataSource {
  @override
  Future<List<Message>> getMessages() async {
    throw UnimplementedError();
  }

  @override
  Future<Unit> addMessage(MessageModel messageModel) async {
    const url = '';

    final data = messageModel.toJson();

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

    print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> editMessage(MessageModel messageModel) async {
    const url = '';

    final data = messageModel.toJson();

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

    print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteMessage(int messageId) async {
    const url = '';

    final data = {
      'id': messageId,
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

    print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
