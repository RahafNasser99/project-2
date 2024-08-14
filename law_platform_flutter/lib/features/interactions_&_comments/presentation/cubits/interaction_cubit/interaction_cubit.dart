import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/usecases/add_interaction_usecase.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/usecases/remove_interaction_usecase.dart';

part 'interaction_state.dart';

class InteractionCubit extends Cubit<InteractionState> {
  AddInteractionUseCase addInteractionUseCase = AddInteractionUseCase();
  RemoveInteractionUseCase removeInteractionUseCase =
      RemoveInteractionUseCase();

  InteractionCubit() : super(InteractionInitial());

  Future<void> addOrRemoveInteraction(String addOrRemove,bool interaction, int postId) async {
    emit(InteractionLoading());

    // interaction is true for like, false for dislike

    final either = addOrRemove == 'add'
        ? await addInteractionUseCase(interaction, postId)
        : await removeInteractionUseCase(interaction, postId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(const InteractionError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const InteractionError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const InteractionError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(InteractionDone()),
    );
  }

  @override
  void onChange(Change<InteractionState> change) {
    print(change.currentState);
    print(change.nextState);
    super.onChange(change);
  }
}
