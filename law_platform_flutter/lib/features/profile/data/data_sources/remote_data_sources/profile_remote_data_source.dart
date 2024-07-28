import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Unit> editProfile(ProfileModel profileModel);
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<Unit> editProfile(ProfileModel profileModel) async {
    const url = '';

    final data = profileModel.toJson();
    final response = await dio.post(
      url,
      data: data,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    const url = '';

    final response = await dio.get(url);

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      final decodedJson = json.decode(response.data);

      final profileModel = ProfileModel.fromJson(decodedJson);

      return profileModel;
    } else {
      throw ServerException();
    }
  }
}
