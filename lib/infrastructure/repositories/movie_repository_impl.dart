import 'package:cosmic_cast/domain/datasources/movies_datasource.dart';
import 'package:cosmic_cast/domain/entities/movie.dart';
import 'package:cosmic_cast/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource datasource;

  MovieRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
}
