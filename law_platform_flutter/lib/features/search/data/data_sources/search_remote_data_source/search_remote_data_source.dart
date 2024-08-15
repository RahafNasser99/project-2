import 'package:dio/dio.dart';
import 'package:law_platform_flutter/features/profile/data/models/lawyer_profile_model.dart';
import 'package:law_platform_flutter/features/profile/data/models/member_profile_model.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/features/profile/data/models/profile_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<ProfileModel>> search(String searchQuery);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  @override
  Future<List<ProfileModel>> search(String searchQuery) async {
    final url = '/api/search/users?query=$searchQuery';

    print('----------------------------------');
    print(searchQuery);

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
      final List decodedJson = response.data['data'] as List;
      final accountType = response.data['account_type'];
      final List<ProfileModel> profileModels = decodedJson
          .map((jsonProfileModel) => accountType == 'member'
              ? MemberProfileModel.fromJson(jsonProfileModel)
              : LawyerProfileModel.fromJson(jsonProfileModel))
          .toList();

      return profileModels;
    } else {
      throw ServerException();
    }
  }
}
