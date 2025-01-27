import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cosmic_cast/config/helpers/human_formats.dart';
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
    return FutureBuilder(
      future: searchMovieCallback(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];

            return _MovieItem(movie: movie);
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        children: [
          //* image
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) =>
                    FadeIn(child: child),
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          //* description
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textStyles.titleMedium,
                ),
                (movie.overview.length > 100)
                    ? Text('${movie.overview.substring(0, 100)}...')
                    : Text(
                        movie.overview,
                      ),
                Row(
                  children: [
                    //* star icon
                    Icon(
                      Icons.star_half_rounded,
                      color: Colors.yellow.shade800,
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    //* rating number
                    Text(
                      HumanFormats.number(movie.voteAverage, 1),
                      style: textStyles.bodyMedium!.copyWith(
                        color: Colors.yellow.shade900,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
