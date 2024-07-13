import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/enum/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/features/profile/domain/usecases/edit_profile_usecase.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileUseCase editProfileUseCase = EditProfileUseCase();

  EditProfileCubit() : super(EditProfileInitial());

  Future<void> editProfile(Profile profile) async {
    emit(EditProfileLoading());

    final either = await editProfileUseCase(profile);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return const EditProfileError(errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const EditProfileError(errorMessage: OFFLINE_SERVER_MESSAGE);
          default:
            return const EditProfileError(
                errorMessage: DEFAULT_FAILURE_MESSAGE);
        }
      },
      (_) => EditProfileDone(),
    );
  }
}
