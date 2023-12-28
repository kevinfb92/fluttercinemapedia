import 'package:cinemapedia/data/models/moviedb/actor_moviedb.dart';

class CreditsMovieDBResponse {
  final int id;
  final List<ActorMovieDB> cast;
  final List<ActorMovieDB> crew;

  CreditsMovieDBResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CreditsMovieDBResponse.fromJson(Map<String, dynamic> json) =>
      CreditsMovieDBResponse(
        id: json["id"],
        cast: List<ActorMovieDB>.from(
            json["cast"].map((x) => ActorMovieDB.fromJson(x))),
        crew: List<ActorMovieDB>.from(
            json["crew"].map((x) => ActorMovieDB.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}
