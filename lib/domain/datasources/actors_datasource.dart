import 'package:cosmic_cast/domain/entities/actor.dart';

abstract class ActorsDataSource {
  
  Future<List<Actor>> getActorsByMovie(String movieId);
}
