import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';

abstract class SignUpRepository {
  Future<Either<Failure, Unit>> signUp(
      String email, String password, AccountType accountType);
}
