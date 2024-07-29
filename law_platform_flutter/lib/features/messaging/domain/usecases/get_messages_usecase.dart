import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/messaging/domain/entities/message.dart';
import 'package:law_platform_flutter/features/messaging/domain/repositories/messaging_repository.dart';
import 'package:law_platform_flutter/features/messaging/data/repositories_impl/messaging_repository_impl.dart';

class GetMessagesUsecase {
  final MessagingRepository messagingRepository = MessagingRepositoryImpl();

  Future<Either<Failure, List<Message>>> call() async {
    return messagingRepository.getMessages();
  }
}
