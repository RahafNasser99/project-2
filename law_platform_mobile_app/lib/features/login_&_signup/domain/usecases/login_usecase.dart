import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/data/repositories_impl/login_repo_impl.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository = LoginRepositoryImpl();

  Future<Either<Failure, Unit>> call(String email, String password) async {
    print('login use case');
    return await repository.login(email, password);
  }
}
