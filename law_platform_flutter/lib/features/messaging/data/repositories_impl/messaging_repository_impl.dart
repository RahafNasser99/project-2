import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/messaging/domain/entities/message.dart';
import 'package:law_platform_flutter/features/messaging/data/models/message_model.dart';
import 'package:law_platform_flutter/features/messaging/domain/repositories/messaging_repository.dart';
import 'package:law_platform_flutter/features/messaging/data/data_sources/messaging_remote_data_source/messaging_remote_data_source.dart';

class MessagingRepositoryImpl extends MessagingRepository {
  MessagingRemoteDataSource messagingRemoteDataSource =
      MessagingRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<Message>>> getMessages() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final returnedMessages = await messagingRemoteDataSource.getMessages();
        return Right(returnedMessages);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addMessages(Message message) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await messagingRemoteDataSource.addMessage(message as MessageModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editMessages(Message message) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await messagingRemoteDataSource.editMessage(message as MessageModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMessages(int messageId) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await messagingRemoteDataSource.deleteMessage(messageId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
