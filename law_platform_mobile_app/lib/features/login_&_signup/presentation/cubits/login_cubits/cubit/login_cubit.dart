import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase = LoginUseCase();
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final either = await loginUseCase(email, password);

    either.fold(
      (failure) {
        print(failure.toString());
        switch (failure.runtimeType) {
          case ServerFailure:
            return const LoginError(errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const LoginError(errorMessage: OFFLINE_SERVER_MESSAGE) ;
          default:
            return const LoginError(errorMessage: DEFAULT_FAILURE_MESSAGE) ;
        }
      },
      (_) => LoginDone(),
    );
  }
}
