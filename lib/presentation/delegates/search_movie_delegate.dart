import 'dart:async';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/helpers/human_formats.dart';
import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  SearchMovieDelegate(
      {required this.searchMoviesCallback, required this.initialMovies});
  final List<Movie> initialMovies;
  final Future<List<Movie>> Function({required String query})
      searchMoviesCallback;
  final StreamController<List<Movie>> debouncedMovies =
      StreamController.broadcast();
  Timer? _debounceTimer;

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive != null) _debounceTimer!.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      () async {
        if (query.isEmpty) {
          debouncedMovies.add([]);
          return;
        }
        final movies = await searchMoviesCallback(query: query);
        debouncedMovies.add(movies);
      },
    );
  }

  void clearStreams() {
    debouncedMovies.close();
  }

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder<List<Movie>>(
      stream: debouncedMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              }),
          itemCount: movies.length,
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext context, Movie movie) onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath),
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: textStyles.titleMedium,
              ),
              (movie.overview.length > 100)
                  ? Text('${movie.overview.substring(0, 100)}...')
                  : Text(movie.overview),
              Row(children: [
                Icon(
                  Icons.star_half_rounded,
                  color: Colors.yellow.shade800,
                ),
                Text(HumanFormats.number(movie.voteAverage, decimals: 1),
                    style: textStyles.bodyMedium!
                        .copyWith(color: Colors.yellow.shade900))
              ])
            ],
          ))
        ]),
      ),
    );
  }
}
