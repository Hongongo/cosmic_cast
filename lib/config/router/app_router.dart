import 'package:go_router/go_router.dart';

import 'package:cosmic_cast/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    //* home screen route
    GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          //* movie screen route
          GoRoute(
            path: '/movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieID = state.pathParameters['id'] ?? 'no-id';
              return MovieScreen(movieId: movieID);
            },
          ),
        ]),
  ],
);
