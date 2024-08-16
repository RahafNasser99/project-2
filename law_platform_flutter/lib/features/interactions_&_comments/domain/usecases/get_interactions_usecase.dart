import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/repositories_impl/interactions_repository_impl.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/repositories/interactions_repository.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

class GetInteractionsUsecase {
  InteractionsRepository interactionsRepository = InteractionsRepositoryImpl();
  Future<Either<Failure, List<Profile>>> call(
      int postId, bool likeOrDislike) async {
    return await interactionsRepository.getInteractions(postId, likeOrDislike);
  }
}
