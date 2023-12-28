import 'package:cinemapedia/data/models/moviedb/actor_moviedb.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

class ActorMapper {
  static Actor actorEntityFromActorMovieDB(ActorMovieDB actorMovieDB) {
    return Actor(
        id: actorMovieDB.id,
        name: actorMovieDB.name,
        profilePath: actorMovieDB.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${actorMovieDB.profilePath}'
            : 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
        character: actorMovieDB.character);
  }
}
