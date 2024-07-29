import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/messaging/domain/entities/message.dart';

abstract class MessagingRepository {
  Future<Either<Failure, List<Message>>> getMessages();
  Future<Either<Failure, Unit>> addMessages(Message message);
  Future<Either<Failure, Unit>> editMessages(Message message);
  Future<Either<Failure, Unit>> deleteMessages(int messageId);
}
