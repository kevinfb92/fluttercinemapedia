import 'package:cinemapedia/domain/datasource/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  final MoviesDatasource moviesDatasource;
  MoviesRepository(this.moviesDatasource);
  Future<List<Movie>> getNowPlaying({int page = 1});
}
