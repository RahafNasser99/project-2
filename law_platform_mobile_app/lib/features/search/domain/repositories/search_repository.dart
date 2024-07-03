import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Profile>>> search(String searchQuery);
}
