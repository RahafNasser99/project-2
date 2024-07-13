import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/enum/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/domain/usecases/signup_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignUpState> {
  SignUpUseCase signUpUseCase = SignUpUseCase();
  SignupCubit() : super(SignUpInitial());

  Future<void> signUp(String name, String email, String password,
      AccountType accountType) async {
    emit(SignUpLoading());

    final either = await signUpUseCase(name, email, password, accountType);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const SignUpError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const SignUpError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const SignUpError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(SignUpDone()),
    );
  }
}
