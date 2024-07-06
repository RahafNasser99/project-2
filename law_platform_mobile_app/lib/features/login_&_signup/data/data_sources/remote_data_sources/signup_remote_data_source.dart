import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/check_authentication.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';

abstract class SignUpRemoteDataSource {
  Future<Unit> signUp(
      String name, String email, String password, AccountType accountType);
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  @override
  Future<Unit> signUp(String name, String email, String password,
      AccountType accountType) async {
    final url = accountType == AccountType.member
        ? '/api/member/register'
        : '/api/lawyer/register';

    final data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };

    final response = await dio.post(
      dio.options.baseUrl + url,
      options: Options(headers: {'Accept': 'application/json'}),
      data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      final CheckAuthentication checkAuthentication = CheckAuthentication();
      final String token = response.data['token'];
      checkAuthentication.storeAuthenticationValue(email, token);
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
