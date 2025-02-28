import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cosmic_cast/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cosmic_cast/infrastructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(
    datasource: MoviedbDatasource(),
  );
});
