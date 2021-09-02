import 'package:get_it/get_it.dart';
import 'package:postor/postor.dart';

import 'core/constants/app_apis.dart';
import 'core/constants/singletons_names.dart';

import 'core/repositories/base_eshows_repo.dart';
import 'core/repositories/base_fav_eshows_repo.dart';

import 'core/repositories/fav_tv_shows_repo/fav_tv_shows_repo.dart';
import 'core/repositories/favmovies_repo/favmovies_repo.dart';

import 'core/repositories/movies_repo/movies_repo.dart';

import 'core/repositories/tv_show_repo/tv_show_repo.dart';

import 'core/services/localdb_service/base_localdb_service.dart';
import 'core/services/localdb_service/localdb_service.dart';

import 'core/services/screen_messenger/base_screen_messenger.dart';
import 'core/services/screen_messenger/screen_messenger.dart';

void initSingletons() {
  // initialize services
  GetIt.I.registerSingleton<Postor>(
    Postor(
      AppApis().baseUrl,
      defaultHeaders: AppApis().defaultHeader,
    ),
  );
  GetIt.I.registerSingleton<BaseLocalDbService>(
    LocalDbService(
      createTablesQueries: const [
        FavMoviesRepository.createFavMovieTableQuery,
        FavTVShowsRepository.createFavTVShowsTableQuery,
      ],
      tablesNames: const [
        FavMoviesRepository.favMoviesTableName,
        FavTVShowsRepository.favTVShowsTableName,
      ],
    ),
  );
  GetIt.I.registerLazySingleton<BaseScreenMessenger>(() => ScreenMessenger());

  // initialize repositories
  GetIt.I.registerSingleton<BaseEShowsRepository>(
    MoviesRepository(),
    instanceName: SIName.repo.movies,
  );
  GetIt.I.registerSingleton<BaseEShowsRepository>(
    TVShowRepository(),
    instanceName: SIName.repo.tvShows,
  );

  GetIt.I.registerSingleton<BaseFavEShowsRepository>(
    FavMoviesRepository(),
    instanceName: SIName.repo.favMovies,
  );
  GetIt.I.registerSingleton<BaseFavEShowsRepository>(
    FavTVShowsRepository(),
    instanceName: SIName.repo.favTVShows,
  );
}
