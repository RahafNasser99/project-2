import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/usecases/login_usecase.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase = LoginUseCase();
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    final either = await loginUseCase(email, password);

    either.fold(
      (failure) {
        print(failure.toString());
        switch (failure.runtimeType) {
          case ServerFailure:
            return SERVER_FAILURE_MESSAGE;
          case OfflineFailure:
            return OFFLINE_SERVER_MESSAGE;
          default:
            return DEFAULT_FAILURE_MESSAGE;
        }
      },
      (_) => LoginDone(),
    );
  }
}
