import 'package:cinemapedia/domain/datasource/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsRepository {
  final ActorsDatasource actorsDatasource;
  ActorsRepository(this.actorsDatasource);
  Future<List<Actor>> getActorsByMovie(String movieId);
}
