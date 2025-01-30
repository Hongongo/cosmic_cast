import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cosmic_cast/presentation/providers/providers.dart';
import 'package:cosmic_cast/presentation/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              'Yikeees!!',
              style: TextStyle(fontSize: 25, color: colors.primary),
            ),
            const Text(
              'No tienes peliculas favoritas',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),

            //* boton de back
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () => context.go('/home/0'),
              child: const Text('Start searching!'),
            ),
          ],
        ),
      );
    }

    return MovieMasonry(
      loadNextPage: loadNextPage,
      movies: favoriteMovies,
    );
  }
}
