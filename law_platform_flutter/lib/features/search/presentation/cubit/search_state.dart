part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchDone extends SearchState {
  final List<Profile> profiles;

  const SearchDone({required this.profiles});
}

final class SearchError extends SearchState {
  final String errorMessage;

  const SearchError({required this.errorMessage});
}
