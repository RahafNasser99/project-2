import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/global_classes/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';

abstract class InteractionsRemoteDataSource {
  Future<Unit> addInteraction(bool interaction);
  Future<Unit> removeInteraction();
}

class InteractionsRemoteDataSourceImpl extends InteractionsRemoteDataSource {
  @override
  Future<Unit> addInteraction(bool interaction) async {
    const url = '';

    final data = {};

    final response = await dio.post(url, data: data);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> removeInteraction() async {
    const url = '';

    final data = {};

    final response = await dio.post(url, data: data);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
