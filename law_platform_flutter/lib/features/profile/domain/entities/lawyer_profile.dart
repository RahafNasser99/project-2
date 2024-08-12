import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';

abstract class LawyerProfile extends Profile {
  final String? specialization;

  LawyerProfile({
    required super.id,
    required super.name,
    required super.email,
    required super.profilePicture,
    required this.specialization,
  });
}
