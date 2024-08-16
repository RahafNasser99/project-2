import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/usecases/get_interactions_usecase.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

part 'get_interactions_state.dart';

class GetInteractionsCubit extends Cubit<GetInteractionsState> {
  GetInteractionsUsecase getInteractionsUsecase = GetInteractionsUsecase();
  GetInteractionsCubit() : super(GetInteractionsInitial());

  Future<void> getInteractions(int postId, bool likeOrDislike) async {
    emit(GetInteractionsLoading());

    final either = await getInteractionsUsecase(postId, likeOrDislike);

     either.fold((failure) {
      switch (failure.runtimeType) {
        case ServerException:
          emit(const GetInteractionsError(errorMessage: SERVER_FAILURE_MESSAGE));
        case OfflineFailure:
          emit(const GetInteractionsError(errorMessage: OFFLINE_SERVER_MESSAGE));
        default:
          emit(const GetInteractionsError(errorMessage: DEFAULT_FAILURE_MESSAGE));
      }
    }, (profiles) {
      if (profiles.isEmpty) {
        emit(GetInteractionsEmpty());
      } else {
        emit(GetInteractionsDone(profiles: profiles));
      }
    });
  }
}
