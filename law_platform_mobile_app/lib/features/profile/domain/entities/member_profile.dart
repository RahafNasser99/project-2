import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';

abstract class MemberProfile extends Profile {
  final String? job;

  MemberProfile({
    required super.id,
    required super.name,
    required super.email,
    required super.profilePicture,
    required this.job,
  });
}
