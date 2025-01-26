import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cosmic_cast/presentation/providers/providers.dart';
import 'package:cosmic_cast/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

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
                    movies: nowPlayingMovies,
                    title: 'Próximamente',
                    subtitle: 'En este mes',
                    loadNextPage: ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage,
                  ),

                  //* populares
                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    // subtitle: 'Lunes 20',
                    loadNextPage: ref
                        .read(popularMoviesProvider.notifier)
                        .loadNextPage,
                  ),

                  //* populares
                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Mejor calificadas',
                    subtitle: 'De todos los tiempos',
                    loadNextPage: ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage,
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
