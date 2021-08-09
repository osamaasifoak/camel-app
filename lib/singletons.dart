import 'package:get_it/get_it.dart';

import '/core/repositories/fav_tv_shows_repo/base_fav_tv_shows_repo.dart';
import '/core/repositories/fav_tv_shows_repo/fav_tv_shows_repo.dart';

import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';
import '/core/repositories/tv_show_repo/tv_show_repo.dart';

import 'core/repositories/favmovies_repo/base_favmovies_repo.dart';
import 'core/repositories/favmovies_repo/favmovies_repo.dart';

import 'core/repositories/movies_repo/base_movies_repo.dart';
import 'core/repositories/movies_repo/movies2_repo/movies2_repo.dart';

import 'core/services/localdb_service/base_localdb_service.dart';
import 'core/services/localdb_service/localdb_service.dart';

import 'core/services/network_service/base_network_service.dart';
import 'core/services/network_service/network_service.dart';

import 'core/services/screen_messenger/base_screen_messenger.dart';
import 'core/services/screen_messenger/screen_messenger.dart';

void initSingletons() {
  // initialize services
  GetIt.I.registerSingleton<BaseNetworkService>(NetworkService());
  GetIt.I.registerSingleton<BaseLocalDbService>(LocalDbService());
  GetIt.I.registerLazySingleton<BaseScreenMessenger>(() => ScreenMessenger());

  // initialize repositories
  GetIt.I.registerSingleton<BaseMoviesRepository>(Movies2Repository());
  GetIt.I.registerSingleton<BaseTVShowRepository>(TVShowRepository());
  
  GetIt.I.registerSingleton<BaseFavMoviesRepository>(FavMoviesRepository());
  GetIt.I.registerSingleton<BaseFavTVShowsRepository>(FavTVShowsRepository());
}
