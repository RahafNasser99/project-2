import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

abstract class LogoutRepository {
  Future<Either<Failure, Unit>> logout();
}
