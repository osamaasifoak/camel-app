import 'package:get_it/get_it.dart';

import 'core/repositories/favmovies_repo/base_favmovies_repo.dart';
import 'core/repositories/favmovies_repo/favmovies_repo.dart';

import 'core/repositories/movies_repo/base_movies_repo.dart';
import 'core/repositories/movies_repo/movies_repo.dart';

import 'core/services/localdb_service/base_localdb_service.dart';
import 'core/services/localdb_service/localdb_service.dart';

import 'core/services/navigation_service/base_navigation_service.dart';
import 'core/services/navigation_service/navigation_service.dart';

import 'core/services/network_service/base_network_service.dart';
import 'core/services/network_service/network_service.dart';

void initSingletons() {

  // initialize services
  GetIt.I.registerSingleton<BaseNetworkService>(NetworkService());
  GetIt.I.registerSingleton<BaseLocalDbService>(LocalDbService()..initDb());
  GetIt.I.registerLazySingleton<BaseNavigationService>(() => NavigationService());
  
  // initialize repositories
  GetIt.I.registerSingleton<BaseMoviesRepository>(MoviesRepository(
    networkService: GetIt.I<BaseNetworkService>(),
  ));
  GetIt.I.registerLazySingleton<BaseFavMoviesRepository>(
    () => FavMoviesRepository(
      localDbService: GetIt.I<BaseLocalDbService>(),
    ),
  );
  
}
