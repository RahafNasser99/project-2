import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';

abstract class SignUpRemoteDataSource {
  Future<Unit> signUp(String email, String password, AccountType accountType);
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  @override
  Future<Unit> signUp(String email, String password, AccountType accountType) async {
    const url = '';
    final data = {
      'email': email,
      'password': password,
      'accountType': accountType,
    };

    final response = await dio.post(
      dio.options.baseUrl + url,
      data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
