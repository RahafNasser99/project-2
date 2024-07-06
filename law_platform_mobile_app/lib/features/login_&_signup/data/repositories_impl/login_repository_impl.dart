import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/repositories/login_repository.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/data/data_sources/remote_data_sources/login_remote_data_source.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<Either<Failure, Unit>> login(String email, String password, AccountType accountType) async {
    LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSourceImpl();

    if (await internetConnectionChecker.hasConnection) {
      try {
        await loginRemoteDataSource.login(email, password,accountType);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
