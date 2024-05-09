import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, Unit>> login(String email, String password);
}
