import 'package:law_platform_flutter/features/profile/data/models/profile_model.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/lawyer_profile.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

class LawyerProfileModel extends LawyerProfile implements ProfileModel {
  LawyerProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.profilePicture,
    required super.specialization,
  });

  factory LawyerProfileModel.fromJson(Map<String, dynamic> json) =>
      LawyerProfileModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        profilePicture: json['profile']['image'] != null
            ? '$BASE_URL${json['profile']['image']}'
            : null,
        specialization: json['profile']['specialization'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": profilePicture,
        "specialization": specialization,
      };
}
