import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/data/mappers/actor_mapper.dart';
import 'package:cinemapedia/data/models/moviedb/credits_moviedb_response.dart';
import 'package:cinemapedia/domain/datasource/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:dio/dio.dart';

class ActorsMovieDBDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.movieDBKey,
      'language': 'es-ES',
    }),
  );
  List<Actor> _jsonToActors(Map<String, dynamic> json) {
    final creditsDbResponse = CreditsMovieDBResponse.fromJson(json);
    final List<Actor> movies = creditsDbResponse.cast
        .map((actorDB) => ActorMapper.actorEntityFromActorMovieDB(actorDB))
        .toList();
    return movies;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200) {
      throw Exception('No se ha encontrado la lista de actores');
    }
    return _jsonToActors(response.data);
  }
}
