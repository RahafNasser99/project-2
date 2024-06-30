import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:law_platform_mobile_app/features/profile/data/repositories_impl/profile_repository_impl.dart';

class EditProfileUseCase {
  ProfileRepository profileRepository = ProfileRepositoryImpl();

  Future<Either<Failure, Unit>> call(Profile profile) async {
    print("edit profile usecase");
    return await profileRepository.editProfile(profile);
  }
}
