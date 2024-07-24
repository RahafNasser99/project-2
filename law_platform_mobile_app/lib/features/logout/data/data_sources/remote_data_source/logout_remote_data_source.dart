import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/global_classes/configurations.dart';
import 'package:law_platform_mobile_app/utils/global_classes/check_authentication.dart';

abstract class LogoutRemoteDataSource {
  Future<Unit> logout();
}

class LogoutRemoteDataSourceImpl extends LogoutRemoteDataSource {
  CheckAuthentication checkAuthentication = CheckAuthentication();

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

    print(response);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      await checkAuthentication.destroyAuthenticationValue();
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
