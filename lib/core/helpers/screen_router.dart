import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/constants/app_routes.dart';
import '/screens.dart';
import '/views/_widgets/circular_reveal_clipper.dart';

class ScreenRouter {

  static PageRoute circularRevealPageRoute({
    required Widget destinationPage,
    Alignment? circularAlignment,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => destinationPage,
      transitionsBuilder: (context, animation, __, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.fastLinearToSlowEaseIn;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: ClipPath(
            clipper: CircularRevealClipper(
              centerAlignment: circularAlignment,
              fraction: animation.value,
            ),
            child: child,
          ),
        );
      },
      settings: settings,
    );
  }

  static Route onGenerateRoute(RouteSettings settings) {
    if(settings.name == AppRoutes.splash) {
      return circularRevealPageRoute(
        destinationPage:  const SplashScreen(),
        settings: settings,
      );
    } else if (settings.name == AppRoutes.favMovies) {
      return circularRevealPageRoute(
        circularAlignment: Alignment.topRight,
        destinationPage: const FavMoviesScreen(),
        settings: settings,
      );
    }
    return CupertinoPageRoute(
      builder: (context) {
        switch (settings.name) {

          case AppRoutes.home:
            return const HomeScreen();

          case AppRoutes.movieDetail:
            final movieId = settings.arguments;
            if (movieId is int) {
              return MovieDetailScreen(movieId: movieId);
            }
            throw ArgumentError(movieId);

          default:
            return const PageNotFoundScreen();
        }
      },
      settings: settings,
    );
  }
}
