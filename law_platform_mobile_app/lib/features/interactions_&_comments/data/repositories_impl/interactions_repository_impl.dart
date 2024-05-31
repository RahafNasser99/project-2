import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/repositories/interactions_repository.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/data/data_sources/remote_data_sources/interactions_remote_data_source.dart';

class InteractionsRepositoryImpl extends InteractionsRepository {
  InteractionsRemoteDataSource interactionsRemoteDataSource =
      InteractionsRemoteDataSourceImpl();
  @override
  Future<Either<Failure, Unit>> addOrRemoveInteraction(bool interaction) async {
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
}
