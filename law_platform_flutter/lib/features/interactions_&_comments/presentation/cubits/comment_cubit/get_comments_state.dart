part of 'get_comments_cubit.dart';

sealed class GetCommentsState extends Equatable {
  const GetCommentsState();

  @override
  List<Object> get props => [];
}

final class GetCommentsInitial extends GetCommentsState {}

final class GetCommentsLoading extends GetCommentsState {}

final class GetCommentsDone extends GetCommentsState {
  final List<Comment> comments;

  const GetCommentsDone({required this.comments});

  @override
  List<Object> get props => [comments];
}

final class GetCommentsIsEmpty extends GetCommentsState {}

final class GetCommentsError extends GetCommentsState {
  final String errorMessage;

  const GetCommentsError({required this.errorMessage});

}
