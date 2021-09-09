import 'package:get_it/get_it.dart' deferred as _get_it show GetIt;
import 'package:postor/postor.dart' deferred as _postor show Postor;

import '/core/constants/app_apis.dart';
import '/core/constants/singletons_names.dart';

import '/core/repositories/base_eshows_repo.dart';
import '/core/repositories/base_fav_eshows_repo.dart';

import '/core/repositories/fav_tv_shows_repo/fav_tv_shows_repo.dart' deferred as _fav_tv_shows_repo;
import '/core/repositories/favmovies_repo/favmovies_repo.dart' deferred as _fav_movies_repo;

import '/core/repositories/movies_repo/movies_repo.dart' deferred as _movies_repo;

import '/core/repositories/tv_show_repo/tv_show_repo.dart' deferred as _tv_show_repo;

import '/core/services/localdb_service/base_localdb_service.dart';
import '/core/services/localdb_service/localdb_service.dart' deferred as _localdb_svc;

import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/core/services/screen_messenger/screen_messenger.dart' deferred as _scr_msgr;

Future<void> initSingletons() async {
  await _get_it.loadLibrary();
  // initialize services
  _postor.loadLibrary().then((_) {
    return _get_it.GetIt.I.registerSingleton(
      _postor.Postor(
        AppApis().baseUrl,
        defaultHeaders: AppApis().defaultHeader,
      ),
    );
  });

  _localdb_svc.loadLibrary().then((_) {
    return _get_it.GetIt.I.registerSingleton<BaseLocalDbService>(
      _localdb_svc.LocalDbService(
        createTablesQueries: const <String>[],
        tablesNames: const <String>[],
      ),
    );
  });

  _scr_msgr.loadLibrary().then((_) {
    return _get_it.GetIt.I.registerLazySingleton<BaseScreenMessenger>(
      () => _scr_msgr.ScreenMessenger(),
    );
  });

  // initialize repositories
  _movies_repo.loadLibrary().then((_) {
    return _get_it.GetIt.I.registerSingleton<BaseEShowsRepository>(
      _movies_repo.MoviesRepository(),
      instanceName: SIName.repo.movies,
    );
  });

  _tv_show_repo.loadLibrary().then((_) {
    return _get_it.GetIt.I.registerSingleton<BaseEShowsRepository>(
      _tv_show_repo.TVShowRepository(),
      instanceName: SIName.repo.tvShows,
    );
  });

  _fav_movies_repo.loadLibrary().then((_) {
    return _get_it.GetIt.I.registerSingleton<BaseFavEShowsRepository>(
      _fav_movies_repo.FavMoviesRepository(),
      instanceName: SIName.repo.favMovies,
    );
  });

  _fav_tv_shows_repo.loadLibrary().then((_) {
    return _get_it.GetIt.I.registerSingleton<BaseFavEShowsRepository>(
      _fav_tv_shows_repo.FavTVShowsRepository(),
      instanceName: SIName.repo.favTVShows,
    );
  });
}
