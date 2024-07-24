import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/features/logout/data/data_sources/remote_data_source/logout_remote_data_source.dart';
import 'package:law_platform_mobile_app/features/logout/domain/repositories/logout_repository.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/global_classes/configurations.dart';

class LogoutRepositoryImpl extends LogoutRepository {
  LogoutRemoteDataSource logoutRemoteDataSource = LogoutRemoteDataSourceImpl();
  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await internetConnectionChecker.hasConnection) {
      print('has connection');

      try {
        await logoutRemoteDataSource.logout();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
