import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/repositories/interactions_repository.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/repositories_impl/interactions_repository_impl.dart';

class AddInteractionUseCase {
  InteractionsRepository interactionsRepository = InteractionsRepositoryImpl();

  Future<Either<Failure, Unit>> call(bool interaction) async {
    print('add interaction use case');
    return await interactionsRepository.addInteraction(interaction);
  }
}
