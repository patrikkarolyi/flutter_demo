import 'package:get_it/get_it.dart';
import 'package:popular_movies/models/db/db.dart';
import 'package:popular_movies/models/db/movie_dao.dart';
import 'package:popular_movies/models/db/movie_disk_data_source.dart';

void setupLocator() {
  final injector = GetIt.instance;
  injector.registerLazySingleton<Db>(() => Db());
  injector.registerLazySingleton<MovieDao>(() => MovieDao(injector()));
  injector.registerLazySingleton<MovieDiskDataSource>(
      () => MovieDiskDataSource(injector()));
}
