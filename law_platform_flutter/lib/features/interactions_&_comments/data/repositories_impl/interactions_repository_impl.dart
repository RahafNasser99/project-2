import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/repositories/interactions_repository.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/data_sources/remote_data_sources/interactions_remote_data_source.dart';

class InteractionsRepositoryImpl extends InteractionsRepository {
  InteractionsRemoteDataSource interactionsRemoteDataSource =
      InteractionsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, Unit>> addInteraction(bool interaction) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await interactionsRemoteDataSource.addInteraction(interaction);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeInteraction() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await interactionsRemoteDataSource.removeInteraction();

        return const Right(unit);

      } on ServerException {
        return Left(OfflineFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
