import 'package:cosmic_cast/domain/datasources/local_storage_datasource.dart';
import 'package:cosmic_cast/domain/entities/movie.dart';
import 'package:isar/isar.dart';

class IsarDatasource extends LocalStorageDataSource {
  late Future<Isar> db;
  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
