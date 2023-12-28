import 'dart:core';

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/views/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) => ActorsByMovieNotifier(
            getActors: ref.watch(actorsRepositoryProvider).getActorsByMovie));

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final Future<List<Actor>> Function(String movieId) getActors;
  bool isLoading = false;
  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) {
      return;
    }
    if (isLoading) return;

    isLoading = true;
    final movie = await getActors(movieId);
    state = {...state, movieId: movie};
    isLoading = false;
  }
}
