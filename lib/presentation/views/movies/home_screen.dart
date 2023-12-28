import 'package:cinemapedia/presentation/views/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/views/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/share/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/share/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const MoviesPlayingNow(),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

class MoviesPlayingNow extends ConsumerStatefulWidget {
  const MoviesPlayingNow({super.key});

  @override
  _MoviesPlayingNowState createState() => _MoviesPlayingNowState();
}

class _MoviesPlayingNowState extends ConsumerState<MoviesPlayingNow> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final topPlayingMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsetsDirectional.zero,
            centerTitle: false,
            title: CustomAppbar()),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              MoviesSlideshow(movies: topPlayingMovies),
              SizedBox(
                height: 400,
                child: MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Viernes 15',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ),
              SizedBox(
                height: 400,
                child: MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Upcoming',
                  subtitle: 'Este mes',
                  loadNextPage: () {
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ),
              SizedBox(
                height: 400,
                child: MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Poulares',
                  loadNextPage: () {
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ),
              SizedBox(
                height: 400,
                child: MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Top Rated',
                  subtitle: 'Desde siempre',
                  loadNextPage: () {
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ),
            ],
          );
        },
        childCount: 1,
      ))
    ]);
  }
}
