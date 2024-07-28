import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/enum/account_type_enum.dart';

abstract class SignUpRepository {
  Future<Either<Failure, Unit>> signUp(
      String name, String email, String password, AccountType accountType);
}
