import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/features/profile/domain/repositories/profile_repository.dart';
import 'package:law_platform_flutter/features/profile/data/data_sources/remote_data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRemoteDataSource profileRemoteDataSource =
      ProfileRemoteDataSourceImpl();

  @override
  Future<Either<Failure, Unit>> editProfile(String? name,String? specializationOrJob, String? imagePath, String? imageName) async {
    if (await internetConnectionChecker.hasConnection) {
      try {

        profileRemoteDataSource.editProfile(name,specializationOrJob, imagePath, imageName);

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
