part of 'add_update_delete_post_cubit.dart';

sealed class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

final class AddUpdateDeletePostLoading extends AddUpdateDeletePostState {}

final class AddUpdateDeletePostDone extends AddUpdateDeletePostState {}

final class AddUpdateDeletePostError extends AddUpdateDeletePostState {
  final String errorMessage;

  const AddUpdateDeletePostError({required this.errorMessage});
}
