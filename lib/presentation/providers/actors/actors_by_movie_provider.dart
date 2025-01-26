import 'package:cosmic_cast/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cosmic_cast/domain/entities/actor.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieProvider, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieProvider( getActors: actorsRepository.getActorsByMovie);
});

/*
  {
  '802341': <Actor>[],
  '802342': <Actor>[],
  '802343': <Actor>[],
  '802340': <Actor>[],
  }

*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieProvider extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieProvider({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActors(movieId);

    state = {...state, movieId: actors}; // => {'$id': movie} como entry del mapa
  }
}
