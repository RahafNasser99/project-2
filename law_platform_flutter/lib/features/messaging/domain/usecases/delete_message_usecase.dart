import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/messaging/domain/repositories/messaging_repository.dart';
import 'package:law_platform_flutter/features/messaging/data/repositories_impl/messaging_repository_impl.dart';

class DeleteMessageUsecase {
  final MessagingRepository messagingRepository = MessagingRepositoryImpl();

  Future<Either<Failure, Unit>> call(int messageId) async {
    return messagingRepository.deleteMessages(messageId);
  }
}
