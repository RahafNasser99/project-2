import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/enum/account_type_enum.dart';

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
      url,
      options: Options(headers: {'Accept': 'application/json'}),
      data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      final String token = response.data['token'];
      final String storedAccountType =
          accountType == AccountType.member ? 'member' : 'lawyer';
      checkAuthentication.storeAuthenticationValue(
        email,
        token,
        storedAccountType,
      );
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
