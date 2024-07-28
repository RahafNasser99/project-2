import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> editProfile(Profile profile);
  Future<Either<Failure, Profile>> getProfile();
}
