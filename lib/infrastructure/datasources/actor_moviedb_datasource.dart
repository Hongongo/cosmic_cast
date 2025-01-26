import 'package:cosmic_cast/domain/datasources/actors_datasource.dart';
import 'package:cosmic_cast/domain/entities/actor.dart';

class ActorMoviedbDataSource extends ActorsDataSource {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    return [];
  }
}
