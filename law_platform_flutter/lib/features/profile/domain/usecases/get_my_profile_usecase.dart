import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:law_platform_flutter/features/profile/domain/repositories/profile_repository.dart';

class GetMyProfileUseCase {
  ProfileRepository profileRepository = ProfileRepositoryImpl();

  Future<Either<Failure, Profile>> call() async {
    return await profileRepository.getMyProfile();
  }
}
