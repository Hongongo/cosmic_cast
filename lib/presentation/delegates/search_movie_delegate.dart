import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cosmic_cast/domain/entities/movie.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovieCallback;

  SearchMovieDelegate({
    required this.searchMovieCallback,
  });

  @override
  String? get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //* icono de limpiar campo
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(
            Icons.clear,
          ),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('sugg');
  }
}
