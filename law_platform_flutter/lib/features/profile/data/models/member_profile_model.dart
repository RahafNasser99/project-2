import 'package:law_platform_flutter/features/profile/data/models/profile_model.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/member_profile.dart';

class MemberProfileModel extends MemberProfile implements ProfileModel {
  MemberProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.accountType,
    required super.profilePicture,
    required super.job,
  });

  factory MemberProfileModel.fromJson(Map<String, dynamic> json) =>
      MemberProfileModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        accountType: 'member',
        profilePicture: json['profile']['image'],
        job: json['profile']['work'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profilePicture": profilePicture,
        "job": job,
      };
}
