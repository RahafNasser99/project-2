import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/logout/domain/usecases/logout_usecase.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutUsecase logoutUsecase = LogoutUsecase();
  
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    final either = await logoutUsecase();

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const LogoutError(
                errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const LogoutError(
                errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const LogoutError(
                errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(LogoutDone()),
    );
  }
}
