import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/features/rate/domain/entities/rate.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

abstract class RateRepositories {
  Future<Either<Failure, Unit>> addRate(Rate rate,int userId);
}
