import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cosmic_cast/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cosmic_cast/infrastructure/repositories/actors_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(ActorMoviedbDataSource());
});
