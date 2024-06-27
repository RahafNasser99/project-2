import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/features/profile/domain/usecases/get_profile.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileUseCase getProfileUseCase = GetProfileUseCase();

  GetProfileCubit() : super(GetProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoading());

    final either = await getProfileUseCase();

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerException:
            return const GetProfileError(errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const GetProfileError(errorMessage: OFFLINE_SERVER_MESSAGE);
          default:
            return const GetProfileError(errorMessage: DEFAULT_FAILURE_MESSAGE);
        }
      },
      (profile) => GetProfileDone(profile: profile),
    );
  }
}
