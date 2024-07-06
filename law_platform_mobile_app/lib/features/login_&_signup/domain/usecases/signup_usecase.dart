import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/repositories/signup_repository.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/data/repositories_impl/signup_repository_impl.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository = SignUpRepositoryImpl();

  Future<Either<Failure, Unit>> call(String name,
      String email, String password, AccountType accountType) async {
    return await signUpRepository.signUp(name,email, password, accountType);
  }
}
