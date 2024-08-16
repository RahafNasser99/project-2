part of 'get_interactions_cubit.dart';

sealed class GetInteractionsState extends Equatable {
  const GetInteractionsState();

  @override
  List<Object> get props => [];
}

final class GetInteractionsInitial extends GetInteractionsState {}

final class GetInteractionsLoading extends GetInteractionsState {}

final class GetInteractionsEmpty extends GetInteractionsState {}

final class GetInteractionsDone extends GetInteractionsState {
  final List<Profile> profiles;

  const GetInteractionsDone({required this.profiles});

  @override
  List<Object> get props => [profiles];
}

final class GetInteractionsError extends GetInteractionsState {
  final String errorMessage;

  const GetInteractionsError({required this.errorMessage});
}
