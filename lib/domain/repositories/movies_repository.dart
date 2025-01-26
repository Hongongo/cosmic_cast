import 'package:cosmic_cast/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});

  
  Future<List<Movie>> getPopular({int page = 1});
}
