import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cosmic_cast/presentation/providers/providers.dart';
import 'package:cosmic_cast/presentation/widgets/widgets.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        //* sliver app bar
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppbar(),
          ),
        ),

        //* sliver list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  //* card carousel
                  MoviesSlideShow(movies: slideShowMovies),

                  //* actualmente
                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subtitle: 'Lunes 20',
                    loadNextPage: ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage,
                  ),

                  //* proximamente
                  MovieHorizontalListView(
                    movies: upcomingMovies,
                    title: 'Próximamente',
                    subtitle: 'En este mes',
                    loadNextPage:
                        ref.read(upcomingMoviesProvider.notifier).loadNextPage,
                  ),

                  //* populares
                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    // subtitle: 'Lunes 20',
                    loadNextPage:
                        ref.read(popularMoviesProvider.notifier).loadNextPage,
                  ),

                  //* mejor calificadas
                  MovieHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subtitle: 'De todos los tiempos',
                    loadNextPage:
                        ref.read(topRatedMoviesProvider.notifier).loadNextPage,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
