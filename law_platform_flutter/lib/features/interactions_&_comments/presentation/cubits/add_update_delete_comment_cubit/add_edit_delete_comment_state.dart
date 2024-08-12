part of 'add_edit_delete_comment_cubit.dart';

sealed class AddEditDeleteCommentState extends Equatable {
  const AddEditDeleteCommentState();

  @override
  List<Object> get props => [];
}

final class AddEditDeleteCommentInitial extends AddEditDeleteCommentState {}

final class AddEditDeleteCommentLoading extends AddEditDeleteCommentState {}

final class AddEditDeleteCommentDone extends AddEditDeleteCommentState {}

final class AddEditDeleteCommentError extends AddEditDeleteCommentState {
  final String errorMessage;

  const AddEditDeleteCommentError({required this.errorMessage});

}
