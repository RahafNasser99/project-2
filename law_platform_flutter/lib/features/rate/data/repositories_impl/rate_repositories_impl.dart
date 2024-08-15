import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/features/rate/domain/entities/rate.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/rate/data/models/rate_model.dart';
import 'package:law_platform_flutter/features/rate/domain/repositories/rate_repositories.dart';
import 'package:law_platform_flutter/features/rate/data/data_sources/rate_remote_data_source/rate_remote_data_source.dart';

class RateRepositoriesImpl extends RateRepositories {
  RateRemoteDataSource rateRemoteDataSource = RateRemoteDataSourceImpl();
  @override
  Future<Either<Failure, Unit>> addRate(Rate rate, int userId) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final RateModel rateModel = RateModel(rateValue: rate.rateValue);
        await rateRemoteDataSource.addRate(rateModel, userId);

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
