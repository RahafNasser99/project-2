import 'dart:convert';

import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/profile/data/models/profile_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<ProfileModel>> search(String searchQuery);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  @override
  Future<List<ProfileModel>> search(String searchQuery) async {
    const url = '';

    final data = {
      'search': searchQuery,
    };

    final response = await dio.get(
      url,
      data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      final List decodedJson = json.decode(response.data) as List;
      final List<ProfileModel> profileModels = decodedJson
          .map((jsonProfileModel) => ProfileModel.fromJson(jsonProfileModel))
          .toList();

      return profileModels;
    } else {
      throw ServerException();
    }
  }
}
