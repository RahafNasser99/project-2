import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

abstract class LogoutRemoteDataSource {
  Future<Unit> logout();
}

class LogoutRemoteDataSourceImpl extends LogoutRemoteDataSource {

  @override
  Future<Unit> logout() async {
    final url = checkAuthentication.getAccountType() == 'lawyer'
        ? '/api/lawyer/logout'
        : '/api/member/logout';

    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${checkAuthentication.getToken()}'
        },
      ),
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      await checkAuthentication.destroyAuthenticationValue();
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
