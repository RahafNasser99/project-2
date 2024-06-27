import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<Either<Failure, Unit>> editProfile(Profile profile) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Profile>> getProfile() {
    throw UnimplementedError();
  }

}