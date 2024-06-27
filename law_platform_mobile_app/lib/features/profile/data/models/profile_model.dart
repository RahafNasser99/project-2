import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';

abstract class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.profilePicture,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson();
}
