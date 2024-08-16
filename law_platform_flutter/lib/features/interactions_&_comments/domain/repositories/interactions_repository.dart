import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

abstract class InteractionsRepository {
  Future<Either<Failure, Unit>> addInteraction(bool interaction,int postId);
  Future<Either<Failure, Unit>> removeInteraction(bool interaction,int postId);
}
