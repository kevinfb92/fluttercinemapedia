import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/views/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) =>
        MovieMapNotifier(
            getMovie: ref.watch(movieRepositoryProvider).getMovieById));

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final Future<Movie> Function({required String id}) getMovie;
  bool isLoading = false;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String id) async {
    if (state[id] != null) {
      return;
    }
    if (isLoading) return;

    isLoading = true;
    final movie = await getMovie(id: id);
    state = {...state, id: movie};
    isLoading = false;
  }
}
