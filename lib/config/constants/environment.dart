import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // ignore: constant_identifier_names
  static const String MOVIEDBKEY = 'THE_MOVIEDB_KEY';
  static String theMovieDbKey = dotenv.env[MOVIEDBKEY] ?? 'No hay api key';
}
