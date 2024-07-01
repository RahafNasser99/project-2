part of 'get_profile_cubit.dart';

sealed class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

final class GetProfileInitial extends GetProfileState {}

final class GetProfileLoading extends GetProfileState {}

final class GetProfileDone extends GetProfileState {
  final Profile profile;

  const GetProfileDone({required this.profile});

  @override
  List<Object> get props => [profile];
}

final class GetProfileError extends GetProfileState {
  final String errorMessage;

  const GetProfileError({required this.errorMessage});
}
