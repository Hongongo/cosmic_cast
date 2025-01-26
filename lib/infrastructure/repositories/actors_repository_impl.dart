import 'package:cosmic_cast/domain/datasources/actors_datasource.dart';
import 'package:cosmic_cast/domain/entities/actor.dart';
import 'package:cosmic_cast/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDataSource dataSource;

  ActorsRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }
}
