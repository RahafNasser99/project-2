import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/data/data_sources/remote_data_sources/login_remote_data_source.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<Either<Failure, Unit>> login(String email, String password) async {
    LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSourceImpl();

    if (await internetConnectionChecker.hasConnection) {
      print('has connection');
      try {
        await loginRemoteDataSource.login(email, password);
        return const Right(unit);
      } on ServerException {
        print('server exception');
        return Left(ServerFailure());
      }
    } else {
      print('offline exception');
      return Left(OfflineFailure());
    }
  }
}
