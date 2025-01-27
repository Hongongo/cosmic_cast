import 'package:go_router/go_router.dart';

import 'package:cosmic_cast/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    //* home screen route
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
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
      ],
    ),

    //* redirect route
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    ),
  ],
);
