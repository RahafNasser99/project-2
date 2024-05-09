import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/constant.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';

abstract class LoginRemoteDataSource {
  Future<Unit> login(String email, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<Unit> login(String email, String password) async {
    const url = '';
    final data = {'email': email, 'password': password};

    print(data['email']);
    print(data['password']);

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
