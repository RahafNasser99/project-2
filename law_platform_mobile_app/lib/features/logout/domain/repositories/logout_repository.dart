import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

abstract class LogoutRepository {
  Future<Either<Failure, Unit>> logout();
}
