import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/repositories/signup_repository.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/data/data_sources/remote_data_sources/signup_remote_data_source.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  SignUpRemoteDataSource signUpRemoteDataSource = SignUpRemoteDataSourceImpl();
  @override
  Future<Either<Failure, Unit>> signUp(String name, String email,
      String password, AccountType accountType) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        await signUpRemoteDataSource.signUp(name, email, password, accountType);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
