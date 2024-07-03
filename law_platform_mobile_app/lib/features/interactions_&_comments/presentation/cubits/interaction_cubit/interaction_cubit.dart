import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_mobile_app/utils/messages.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/usecases/add_interaction_usecase.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/usecases/remove_interaction_usecase.dart';

part 'interaction_state.dart';

class InteractionCubit extends Cubit<InteractionState> {
  AddInteractionUseCase addInteractionUseCase = AddInteractionUseCase();
  RemoveInteractionUseCase removeInteractionUseCase =
      RemoveInteractionUseCase();

  InteractionCubit() : super(InteractionInitial());

  Future<void> addOrRemoveInteraction(bool? interaction) async {
    emit(InteractionLoading());

    final either = interaction != null
        ? await addInteractionUseCase(interaction)
        : await removeInteractionUseCase();

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return const InteractionError(errorMessage: SERVER_FAILURE_MESSAGE);
          case OfflineFailure:
            return const InteractionError(errorMessage: OFFLINE_SERVER_MESSAGE);
          default:
            return const InteractionError(
                errorMessage: DEFAULT_FAILURE_MESSAGE);
        }
      },
      (_) => InteractionDone(),
    );
  }
}
