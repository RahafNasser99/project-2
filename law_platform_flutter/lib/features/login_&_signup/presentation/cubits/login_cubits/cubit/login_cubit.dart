import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/enum/account_type_enum.dart';
import 'package:law_platform_flutter/features/login_&_signup/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase = LoginUseCase();
  LoginCubit() : super(LoginInitial());

  Future<void> login(
      String email, String password, AccountType accountType) async {
    emit(LoginLoading());

    final either = await loginUseCase(email, password, accountType);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const LoginError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const LoginError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const LoginError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(LoginDone()),
    );
  }
}
