import 'package:dartz/dartz.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/features/search/data/repositories_impl/search_repository_impl.dart';
import 'package:law_platform_flutter/features/search/domain/repositories/search_repository.dart';
import 'package:law_platform_flutter/utils/error/failures.dart';

class SearchUseCase {
  final SearchRepository searchRepository = SearchRepositoryImpl();
  
  Future<Either<Failure, List<Profile>>> call(String searchQuery) async {
    return await searchRepository.search(searchQuery);
  }
}
