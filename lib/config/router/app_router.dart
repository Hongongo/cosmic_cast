import 'package:go_router/go_router.dart';

import 'package:cosmic_cast/presentation/screens/screens.dart';
import '../../presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      //* home screen route
      builder: (context, state, child) => HomeScreen(childView: child),
      routes: [
        //* home view
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              path: '/movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieID = state.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: movieID);
              },
            ),
          ],
        ),
        //* favorites view
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ],
    ),

    // //* home screen route
    // GoRoute(
    //     path: '/',
    //     name: HomeScreen.name,
    //     builder: (context, state) => const HomeScreen(
    //           childView: HomeView(),
    //         ),
    //     routes: [
    //       //* movie screen route
    //       GoRoute(
    //         path: '/movie/:id',
    //         name: MovieScreen.name,
    //         builder: (context, state) {
    //           final movieID = state.pathParameters['id'] ?? 'no-id';
    //           return MovieScreen(movieId: movieID);
    //         },
    //       ),
    //     ]),
  ],
);
