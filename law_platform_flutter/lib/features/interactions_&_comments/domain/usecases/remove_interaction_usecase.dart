import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/repositories_impl/interactions_repository_impl.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/repositories/interactions_repository.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

class RemoveInteractionUseCase {
  InteractionsRepository interactionsRepository = InteractionsRepositoryImpl();

  Future<Either<Failure, Unit>> call() async {
    print("remove interaction usecase");
    return await interactionsRepository.removeInteraction();
  }
}
