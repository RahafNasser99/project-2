import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/enum/account_type_enum.dart';

abstract class LoginRepository {
  Future<Either<Failure, Unit>> login(String email, String password, AccountType accountType);
}
