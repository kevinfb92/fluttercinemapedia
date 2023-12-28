import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/views/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) => MoviesNotifier(
        fetchMoreMovies: ref.watch(movieRepositoryProvider).getNowPlaying));

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) => MoviesNotifier(
        fetchMoreMovies: ref.watch(movieRepositoryProvider).getPopular));

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) => MoviesNotifier(
        fetchMoreMovies: ref.watch(movieRepositoryProvider).getTopRated));

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) => MoviesNotifier(
        fetchMoreMovies: ref.watch(movieRepositoryProvider).getUpcoming));

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  final Future<List<Movie>> Function({int page}) fetchMoreMovies;
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> nextMovies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...nextMovies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
