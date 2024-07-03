import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/features/search/domain/usecases/search_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase = SearchUseCase();

  SearchCubit() : super(SearchInitial());

  Future<void> search(String searchQuery) async {
    emit(SearchLoading());

    final either = await searchUseCase(searchQuery);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerException:
            return const SearchError(errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const SearchError(errorMessage: OFFLINE_SERVER_MESSAGE);
          default:
            return const SearchError(errorMessage: DEFAULT_FAILURE_MESSAGE);
        }
      },
      (profiles) => SearchDone(profiles: profiles),
    );
  }
}
