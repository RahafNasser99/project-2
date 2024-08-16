import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/rate/domain/entities/rate.dart';
import 'package:law_platform_flutter/features/rate/domain/repositories/rate_repositories.dart';
import 'package:law_platform_flutter/features/rate/data/repositories_impl/rate_repositories_impl.dart';

class AddRateUsecase {
  RateRepositories rateRepositories = RateRepositoriesImpl();
  Future<Either<Failure, Unit>> call(Rate rate, int userId) async {
    return await rateRepositories.addRate(rate, userId);
  }
}
