import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repository/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  MovieRepositoryImpl(super.moviesDatasource);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDatasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return moviesDatasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return moviesDatasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return moviesDatasource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById({required String id}) {
    return moviesDatasource.getMovieById(id: id);
  }

  @override
  Future<List<Movie>> searchMovie({required String query}) {
    return moviesDatasource.searchMovie(query: query);
  }
}
