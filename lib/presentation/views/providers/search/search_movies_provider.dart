import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/views/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  return SearchedMoviesNotifier(
      searchMovies: ref.read(movieRepositoryProvider).searchMovie, ref: ref);
});

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);
  final Future<List<Movie>> Function({required String query}) searchMovies;
  final Ref ref;
  Future<List<Movie>> searchMoviesByQuery({required String query}) async {
    final List<Movie> movies = await searchMovies(query: query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
