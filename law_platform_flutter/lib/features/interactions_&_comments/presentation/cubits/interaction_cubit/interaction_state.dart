part of 'interaction_cubit.dart';

sealed class InteractionState extends Equatable {
  const InteractionState();

  @override
  List<Object> get props => [];
}

final class InteractionInitial extends InteractionState {}

final class InteractionLoading extends InteractionState {}

final class InteractionDone extends InteractionState {}

final class InteractionError extends InteractionState {
  final String errorMessage;

  const InteractionError({required this.errorMessage});

}
