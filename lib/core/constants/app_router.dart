import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/views/_widgets/error_screen.dart';
import '../../../screens.dart';

class AppRoutes {
  static const String home = '/';
  static const String error = '/error';
  static const String splash = '/splash';
  static const String movieDetail = '/detail';
  static const String favMovies = '/favs';
}

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      switch (settings.name) {
        case AppRoutes.home:
          return const HomeScreen();
        case AppRoutes.splash:
          return const SplashScreen();
        case AppRoutes.movieDetail:
          return MovieDetailScreen(movieId: settings.arguments as num?);
        case AppRoutes.favMovies:
          return const FavMoviesScreen();
        default:
          return _pageNotFoundScreen(context);
      }
    });
  }
}

Widget _pageNotFoundScreen(BuildContext context) => Scaffold(
  appBar: AppBar(
    leading: IconButton(
      onPressed: Navigator.of(context).pop,
      icon: Icon(
        Icons.arrow_back_ios_new,
      ),
    ),
  ),
  body: Center(
    child: ErrorScreen(
      errorMessage: 'Oopss... The page you\'re looking for does not exist',
      onRetry: Navigator.of(context).pop,
    ),
  ),
);
