import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/features/logout/data/repositories_impl/logout_repository_impl.dart';
import 'package:law_platform_mobile_app/features/logout/domain/repositories/logout_repository.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

class LogoutUsecase {
  final LogoutRepository logoutRepository = LogoutRepositoryImpl();
  Future<Either<Failure, Unit>> call() async {
    return logoutRepository.logout();
  }
}
