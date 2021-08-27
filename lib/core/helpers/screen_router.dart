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
          alignment: circularAlignment ?? Alignment.center,
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
    final String? routeUri = settings.name;

    if (routeUri == null) {
      return CupertinoPageRoute(builder: (_) => const PageNotFoundScreen());
    }

    final Uri routeUriData = Uri.parse(routeUri);
    final String routePath = routeUriData.path;
    final Map<String, String> routeParameters = routeUriData.queryParameters;

    if (routePath == AppRoutes.splash) {
      return circularRevealPageRoute(
        destinationPage: const SplashScreen(),
        settings: settings,
      );
    }
    if (routePath == AppRoutes.favMovies) {
      return circularRevealPageRoute(
        circularAlignment: Alignment.topRight,
        destinationPage: const FavMoviesScreen(),
        settings: settings,
      );
    }
    if (routePath == AppRoutes.favTVShows) {
      return circularRevealPageRoute(
        circularAlignment: Alignment.topRight,
        destinationPage: const FavTVShowsScreen(),
        settings: settings,
      );
    }

    return CupertinoPageRoute(
      builder: (context) {
        if (routePath == AppRoutes.home) {
          return const HomeScreen();
        }
        if (routePath == AppRoutes.nowPlayingMovieList) {
          return const NowPlayingListScreen();
        }
        if (routePath == AppRoutes.popularMovieList) {
          return const PopularListScreen();
        }
        if (routePath == AppRoutes.upcomingMovieList) {
          return const UpcomingListScreen();
        }
        if (routePath == AppRoutes.movieDetail) {
          final movieId = int.tryParse(routeParameters['id'] ?? '-');
          if (movieId is int) {
            return MovieDetailScreen(movieId: movieId);
          }
        }
        if (routePath == AppRoutes.popularTVShowList) {
          return const PopularTVShowListScreen();
        }
        if (routePath == AppRoutes.onTheAirTVShowList) {
          return const OnTheAirTVShowListScreen();
        }
        if (routePath == AppRoutes.tvShowDetail) {
          final tvShowId = int.tryParse(routeParameters['id'] ?? '-');
          if (tvShowId is int) {
            return TVShowDetailScreen(tvShowId: tvShowId);
          }
        }

        return const PageNotFoundScreen();
      },
      settings: settings,
    );
  }
}
