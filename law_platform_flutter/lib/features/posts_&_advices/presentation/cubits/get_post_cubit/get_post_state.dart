part of 'get_post_cubit.dart';

sealed class GetPostState extends Equatable {
  const GetPostState();

  @override
  List<Object> get props => [];
}

final class GetPostInitial extends GetPostState {}

final class GetPostLoading extends GetPostState {}

final class GetPostIsEmpty extends GetPostState {}

final class GetPostDone extends GetPostState {
  final int pageCount;
  final List<Post> posts;

  const GetPostDone({required this.pageCount, required this.posts});

  @override
  List<Object> get props => [pageCount,posts];
}

final class GetPostError extends GetPostState {
  final String errorMessage;

  const GetPostError({required this.errorMessage});
}
