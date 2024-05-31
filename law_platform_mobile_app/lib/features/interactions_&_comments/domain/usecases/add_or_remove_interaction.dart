import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/repositories/interactions_repository.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/data/repositories_impl/interactions_repository_impl.dart';

class AddRemoveInteractionUseCase {
  InteractionsRepository interactionsRepository = InteractionsRepositoryImpl();

  Future<Either<Failure, Unit>> addOrRemoveInteraction(bool interaction) async {
    print('interaction use case');
    return await interactionsRepository.addOrRemoveInteraction(interaction);
  }
}
