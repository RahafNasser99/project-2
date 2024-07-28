import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/enum/account_type_enum.dart';
import 'package:law_platform_flutter/features/login_&_signup/domain/repositories/login_repository.dart';
import 'package:law_platform_flutter/features/login_&_signup/data/repositories_impl/login_repository_impl.dart';

class LoginUseCase {
  final LoginRepository repository = LoginRepositoryImpl();

  Future<Either<Failure, Unit>> call(
      String email, String password, AccountType accountType) async {
    return await repository.login(email, password, accountType);
  }
}
