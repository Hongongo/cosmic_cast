import 'package:dio/dio.dart';

import 'package:cosmic_cast/config/constants/environment.dart';
import 'package:cosmic_cast/domain/datasources/actors_datasource.dart';
import 'package:cosmic_cast/domain/entities/actor.dart';
import 'package:cosmic_cast/infrastructure/mappers/actor_mapper.dart';
import 'package:cosmic_cast/infrastructure/models/moviedb/credits_response.dart';

class ActorMoviedbDataSource extends ActorsDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'en-US',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast),
    ).toList();

    return actors;
  }
}
