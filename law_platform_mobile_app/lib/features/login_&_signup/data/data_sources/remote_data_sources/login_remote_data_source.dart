import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';

abstract class LoginRemoteDataSource {
  Future<Unit> login(String email, String password, AccountType accountType);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<Unit> login(
      String email, String password, AccountType accountType) async {
    final url = accountType == AccountType.member
        ? '/api/member/login'
        : '/api/lawyer/login';
    final data = {'email': email, 'password': password};

    final response = await dio.post(
      dio.options.baseUrl + url,
      options: Options(headers: {'Accept': 'application/json'}),
      data: data,
    );

    print(response.data);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
