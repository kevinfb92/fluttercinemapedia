import 'package:cinemapedia/data/datasources/actors_moviedb_datasource.dart';
import 'package:cinemapedia/data/repositories/actors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider =
    Provider((ref) => ActorsRepositoryImpl(ActorsMovieDBDatasource()));
