import 'package:cosmic_cast/config/constants/environment.dart';
import 'package:cosmic_cast/domain/datasources/movies_datasource.dart';
import 'package:cosmic_cast/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'lenguage': 'en-US',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movies/now_playing');
    final List<Movie> movies = [];
    return movies;
  }
}
