import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';

abstract class InteractionsRepository {
  Future<Either<Failure, List<Profile>>> getInteractions(int postId,bool likeOrDislike);
  Future<Either<Failure, Unit>> addInteraction(bool interaction,int postId);
  Future<Either<Failure, Unit>> removeInteraction(bool interaction,int postId);
}
