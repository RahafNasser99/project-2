import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/profile/data/models/profile_model.dart';
import 'package:law_platform_flutter/features/profile/data/models/member_profile_model.dart';
import 'package:law_platform_flutter/features/profile/data/models/lawyer_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Unit> editProfile(
      String? specializationOrJob, String? imagePath, String? imageName);
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<Unit> editProfile(
      String? specializationOrJob, String? imagePath, String? imageName) async {
    final url = checkAuthentication.getAccountType() == 'member'
        ? '/api/member/editProfile'
        : '/api/lawyer/editProfile';

    MultipartFile? multipartFile = (imagePath != null)
        ? await MultipartFile.fromFile(imagePath, filename: imageName)
        : null;

    FormData formData = FormData.fromMap({
      'biography': 'biography',
      'specialization': specializationOrJob,
      'image': multipartFile,
    });

    final response = await dio.post(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${checkAuthentication.getToken()}'
        },
      ),
      data: formData,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    final url = checkAuthentication.getAccountType() == 'member'
        ? '/api/member/viewProfile'
        : '/api/lawyer/viewProfile';

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
      final decodedJson = response.data['data'];

      final profileModel = checkAuthentication.getAccountType() == 'member'
          ? MemberProfileModel.fromJson(decodedJson)
          : LawyerProfileModel.fromJson(decodedJson['lawyer']);

      return profileModel;
    } else {
      throw ServerException();
    }
  }
}
