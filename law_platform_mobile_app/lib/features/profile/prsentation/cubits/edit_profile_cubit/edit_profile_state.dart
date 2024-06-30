part of 'edit_profile_cubit.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileDone extends EditProfileState {}

final class EditProfileError extends EditProfileState {
  final String errorMessage;

  const EditProfileError({required this.errorMessage});
}
