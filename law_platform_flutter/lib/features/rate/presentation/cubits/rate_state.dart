part of 'rate_cubit.dart';

sealed class RateState extends Equatable {
  const RateState();

  @override
  List<Object> get props => [];
}

final class RateInitial extends RateState {}

final class RateLoading extends RateState {}

final class RateDone extends RateState {}

final class RateError extends RateState {
  final String errorMessage;

  const RateError({required this.errorMessage});
}
