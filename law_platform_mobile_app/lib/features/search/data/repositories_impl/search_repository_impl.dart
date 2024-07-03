import 'package:dartz/dartz.dart';
import 'package:law_platform_mobile_app/utils/error/failures.dart';
import 'package:law_platform_mobile_app/utils/configurations.dart';
import 'package:law_platform_mobile_app/utils/error/exceptions.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/features/search/domain/repositories/search_repository.dart';
import 'package:law_platform_mobile_app/features/search/data/data_sources/search_remote_data_source/search_remote_data_source.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource =
      SearchRemoteDataSourceImpl();
  @override
  Future<Either<Failure, List<Profile>>> search(String searchQuery) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final profiles = await searchRemoteDataSource.search(searchQuery);

        return Right(profiles);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
