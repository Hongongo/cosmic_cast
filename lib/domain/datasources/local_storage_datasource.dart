import 'package:cosmic_cast/domain/entities/movie.dart';

abstract class LocalStorageDataSource{
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovies({limit = 10, offset =0});
}