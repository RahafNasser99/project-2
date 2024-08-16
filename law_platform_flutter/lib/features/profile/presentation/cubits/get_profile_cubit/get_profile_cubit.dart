import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:law_platform_flutter/features/profile/domain/usecases/get_another_user_profile_usecase.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetMyProfileUseCase getProfileUseCase = GetMyProfileUseCase();
  GetAnotherUserProfileUseCase getAnotherUserProfileUseCase =
      GetAnotherUserProfileUseCase();

  GetProfileCubit() : super(GetProfileInitial());

  Future<void> getMyProfile() async {
    emit(GetProfileLoading());

    final either = await getProfileUseCase();

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerException:
            emit(const GetProfileError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const GetProfileError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const GetProfileError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (profile) => emit(GetProfileDone(profile: profile)),
    );
  }

  Future<void> getAnotherUserProfile(String accountType, int userId) async {
    emit(GetProfileLoading());

    final either = await getAnotherUserProfileUseCase(accountType, userId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerException:
            emit(const GetProfileError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const GetProfileError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const GetProfileError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (profile) => emit(GetProfileDone(profile: profile)),
    );
  }
}
