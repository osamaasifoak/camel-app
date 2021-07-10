
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_apis.dart';
import 'core/constants/app_routes.dart';
import 'core/helpers/app_bloc_observer.dart';
import 'core/repositories/movies_repo.dart';
import 'core/services/navigation_service/navigation_service.dart';

import 'views/favmovies/cubit/favmovies_cubit.dart';
import 'views/favmovies/screen/_favmovies_screen.dart';
import 'views/home/screen/_home_screen.dart';
import 'views/home/tabs/nowplaying/cubit/nowplaying_cubit.dart';
import 'views/home/tabs/upcoming/cubit/upcoming_cubit.dart';
import 'views/moviedetail/cubit/moviedetail_cubit.dart';
import 'views/moviedetail/screen/_moviedetail_screen.dart';
import 'views/splash_screen.dart';

import 'singletons.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await AppApis().loadApiKey();

  Bloc.observer = AppBlocObserver();

  initSingletons();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => MoviesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailCubit>(
            create: (context) =>
              MovieDetailCubit(
                moviesRepo: context.read<MoviesRepository>(), 
              ),
          ),
          BlocProvider<FavMoviesCubit>(
            create: (context) =>
              FavMoviesCubit(
                moviesRepo: context.read<MoviesRepository>(),
              ),
          ),
          BlocProvider<NowPlayingCubit>(
            create: (context) =>
              NowPlayingCubit(
                moviesRepo: context.read<MoviesRepository>(),
              ),
          ),
          BlocProvider<UpcomingCubit>(
            create: (context) =>
              UpcomingCubit(
                moviesRepo: context.read<MoviesRepository>(),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'caMel',          
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          scaffoldMessengerKey: NavigationService.messengerKey,
          theme: ThemeData(
            primaryColor: Colors.grey[50],
            accentColor: Color(0xFF01579B), //Colors.grey[900],
            errorColor: const Color(0xffD50000),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color(0xff40C4FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                )
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: const Color(0xff40C4FF),
                )
            ),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            })
          ),
          initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.home: (_) => const HomeScreen(),
            AppRoutes.favMovies: (_) => const FavMoviesScreen(),
            AppRoutes.movieDetail: (_) => const MovieDetailScreen(),
            AppRoutes.splash: (_) => const SplashScreen(),
          },
          // initialRoute: AppRoutes.splash,
          // onGenerateRoute: CustomRouter.onGenerateRoute,
          // home: HomeScreen(),
        ),
      ),
    );
  }
}
