import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import 'package:cosmic_cast/domain/entities/movie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          //* sliver appbar
          _CustomSliverAppbar(
            movie: movie,
          ),

          //* sliver list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose(
  (ref, int movieId) {
    final localStorageRepo = ref.watch(localStorageRepositroyProvider);
    return localStorageRepo.isMovieFavorite(movieId);
  },
);

class _CustomSliverAppbar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppbar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .watch(localStorageRepositroyProvider)
                .toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture.when(
            data: (isFavorite) => isFavorite
                ? const Icon(Icons.favorite_rounded, color: Colors.red)
                : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(),
            loading: () => const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        background: Stack(
          children: [
            //* imagen de la pelicula
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Placeholder(),
              ),
            ),

            //* gradiente imagen
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),

            //* gradiente back btn
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* imagen del poster
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) return const SizedBox();
                    return FadeIn(child: child);
                  },
                  errorBuilder: (context, error, stackTrace) => SizedBox(
                    width: size.width * 0.3,
                    child: const Placeholder(),
                  ),
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              //* overview
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleLarge,
                    ),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),

        //* generos de la pelicula
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsByMovie[movieId]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: ListView.separated(
          itemCount: actors.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10); // Adds padding of 16 pixels
          },
          itemBuilder: (BuildContext context, int index) {
            final actor = actors[index];

            return SizedBox(
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* actor photo
                  FadeInRight(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        width: 135,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) return const SizedBox();
                          return FadeIn(child: child);
                        },
                        // TODO: replace place holder with error image
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                          height: 180,
                          width: 135,
                          child: Placeholder(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    actor.name,
                    maxLines: 2,
                  ),
                  Text(
                    actor.character ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  //* nombre
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
