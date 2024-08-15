import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/utils/enum/messages.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/utils/error/exceptions.dart';
import 'package:law_platform_flutter/features/rate/domain/entities/rate.dart';
import 'package:law_platform_flutter/features/rate/domain/usecases/add_rate_usecase.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  AddRateUsecase addRateUsecase = AddRateUsecase();
  RateCubit() : super(RateInitial());

  Future<void> addRate(Rate rate, int userId) async {
    emit(RateLoading());

    final either = await addRateUsecase(rate, userId);

    either.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerException:
            emit(const RateError(errorMessage: SERVER_FAILURE_MESSAGE));
          case OfflineFailure:
            emit(const RateError(errorMessage: OFFLINE_SERVER_MESSAGE));
          default:
            emit(const RateError(errorMessage: DEFAULT_FAILURE_MESSAGE));
        }
      },
      (_) => emit(RateDone()),
    );
  }
}
