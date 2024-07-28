part of 'signup_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpError extends SignUpState {
  final String errorMessage;

  const SignUpError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class SignUpDone extends SignUpState {}
