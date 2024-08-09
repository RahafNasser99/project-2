import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/profile/domain/usecases/edit_profile_usecase.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileUseCase editProfileUseCase = EditProfileUseCase();

  EditProfileCubit() : super(EditProfileInitial());

  Future<void> editProfile(
      String? specializationOrJob, String? imagePath, String? imageName) async {
    emit(EditProfileLoading());

    final either =
        await editProfileUseCase(specializationOrJob, imagePath, imageName);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const EditProfileError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const EditProfileError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const EditProfileError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(EditProfileDone()),
    );
  }
}
