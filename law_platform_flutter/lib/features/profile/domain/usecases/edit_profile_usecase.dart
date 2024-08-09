import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/profile/domain/repositories/profile_repository.dart';
import 'package:law_platform_flutter/features/profile/data/repositories_impl/profile_repository_impl.dart';

class EditProfileUseCase {
  ProfileRepository profileRepository = ProfileRepositoryImpl();

  Future<Either<Failure, Unit>> call(String? specializationOrJob, String? imagePath, String? imageName) async {
    print("edit profile usecase");
    return await profileRepository.editProfile(specializationOrJob, imagePath, imageName);
  }
}
