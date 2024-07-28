import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Profile>>> search(String searchQuery);
}
