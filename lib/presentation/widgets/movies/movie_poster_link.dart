import 'package:flutter/widgets.dart';

import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

import 'package:cosmic_cast/domain/entities/movie.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movie.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeIn(
          child: Image.network(
            movie.posterPath,
          ),
        ),
      ),
    );
  }
}
