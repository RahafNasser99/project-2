import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:law_platform_flutter/features/rate/data/models/rate_model.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

abstract class RateRemoteDataSource {
  Future<Unit> addRate(RateModel rateModel, int userId);
}

class RateRemoteDataSourceImpl extends RateRemoteDataSource {
  @override
  Future<Unit> addRate(RateModel rateModel, int userId) async {
    final url = '/api/lawyers/$userId/rate';

    final data = rateModel.toJson();

    final response = await dio.post(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${checkAuthentication.getToken()}'
        },
      ),
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
