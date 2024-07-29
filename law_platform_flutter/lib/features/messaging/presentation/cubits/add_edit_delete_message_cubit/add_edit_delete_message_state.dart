part of 'add_edit_delete_message_cubit.dart';

sealed class AddEditDeleteMessageState extends Equatable {
  const AddEditDeleteMessageState();

  @override
  List<Object> get props => [];
}

final class AddEditDeleteMessageInitial extends AddEditDeleteMessageState {}

final class AddEditDeleteMessageLoading extends AddEditDeleteMessageState {}

final class AddEditDeleteMessageDone extends AddEditDeleteMessageState {}

final class AddEditDeleteMessageError extends AddEditDeleteMessageState {
  final String errorMessage;

  const AddEditDeleteMessageError({required this.errorMessage});
}
