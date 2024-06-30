import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';

abstract class SignUpRemoteDataSource {
  Future<Unit> signUp(String email, String password, AccountType accountType);
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  @override
  Future<Unit> signUp(
      String email, String password, AccountType accountType) async {
    final url = accountType == AccountType.member
        ? '/api/member/register'
        : '/api/lawyer/register';

    print(dio.options.baseUrl + url);
    final data = {
      'email': email,
      'password': password,
      'password_confirmation': password,
    };

    print('**********************************');

    final response = await dio.post(
      dio.options.baseUrl + url,
      data: data,
    );

    print('-------------------------------------------------');

    print(response.statusCode);
    print(response.statusMessage);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      print('200 -> 400');
      print(response.statusCode);
      print(response.statusMessage);
      return Future.value(unit);
    } else {
      print('401 -->');
      print(response.statusCode);
      print(response.statusMessage);
      throw ServerException();
    }
  }
}
