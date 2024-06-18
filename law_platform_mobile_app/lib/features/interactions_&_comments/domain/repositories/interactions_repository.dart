import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

abstract class InteractionsRepository {
  Future<Either<Failure, Unit>> addOrRemoveInteraction(bool interaction);
}
