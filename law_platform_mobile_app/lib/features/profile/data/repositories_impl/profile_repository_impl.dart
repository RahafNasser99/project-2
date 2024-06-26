import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/features/profile/data/models/profile_model.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/member_profile.dart';
import 'package:law_platform_mobile_app/features/profile/data/models/member_profile_model.dart';
import 'package:law_platform_mobile_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:law_platform_mobile_app/features/profile/data/data_sources/remote_data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRemoteDataSource profileRemoteDataSource =
      ProfileRemoteDataSourceImpl();

  @override
  Future<Either<Failure, Unit>> editProfile(Profile profile) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        // change depends on account type
        ProfileModel profileModel = MemberProfileModel(
          id: profile.id,
          name: profile.name,
          email: profile.email,
          profilePicture: profile.profilePicture,
          job: (profile as MemberProfile).job,
        );

        profileRemoteDataSource.editProfile(profileModel);

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final profile = await profileRemoteDataSource.getProfile();

        return Right(profile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
