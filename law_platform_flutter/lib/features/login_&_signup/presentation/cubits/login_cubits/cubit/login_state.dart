part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  final String errorMessage;

  const LoginError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class LoginDone extends LoginState {}
