import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repository/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  ActorsRepositoryImpl(super.actorsDatasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return actorsDatasource.getActorsByMovie(movieId);
  }
}
