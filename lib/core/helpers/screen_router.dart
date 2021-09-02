import 'dart:developer' as _dev show log;

import 'package:flutter/material.dart';

import '/core/constants/app_routes.dart';
import '/screens.dart';
import '/views/_widgets/circular_reveal_clipper.dart';

const log = _dev.log;

class ScreenRouter {
  static final ScreenRouter _instance = ScreenRouter._internal();

  factory ScreenRouter() => _instance;

  ScreenRouter._internal();

  PointerDownEvent? _pointerDownEvent;

  void onPointerDownEvent(PointerDownEvent newPointerDownEvent) {
    log(newPointerDownEvent.toString());
    _pointerDownEvent = newPointerDownEvent;
  }

  static const double _defaultTweenDoubleBegin = 0.0;
  static const double _defaultTweenDoubleEnd = 1.0;
  static const Curve _defaultTweenDoubleCurve = Curves.fastLinearToSlowEaseIn;

  static final Animatable<Offset> _defaultTweenOffset = Tween<Offset>(
    begin: _defaultTweenOffsetBegin,
    end: _defaultTweenOffsetEnd,
  );
  static const Offset _defaultTweenOffsetBegin = Offset(1.0, 0.0);
  static const Offset _defaultTweenOffsetEnd = Offset.zero;
  static const Curve _defaultTweenOffsetCurve = Curves.easeIn;

  Animatable<double> get _defaultTweenDouble {
    return Tween<double>(
      begin: _defaultTweenDoubleBegin,
      end: _defaultTweenDoubleEnd,
    ).chain(CurveTween(curve: _defaultTweenDoubleCurve));
  }

  Animatable<Offset> get _defaultCurvedTweenOffset {
    return _defaultTweenOffset.chain(CurveTween(curve: _defaultTweenOffsetCurve));
  }

  Route onGenerateRoute(RouteSettings settings) {
    final String? routeName = settings.name;
    final Object? routeArgs = settings.arguments;
    final Widget destPage;
    Alignment? circularAlignment;
    bool useFadeTransition = false;

    if (routeName == null) {
      circularAlignment = Alignment.center;
      destPage = const PageNotFoundScreen();
    } else {
      final Uri routeUri = Uri.parse(routeName);
      final String routePath = routeUri.path;

      if (routePath == AppRoutes.splash) {
        circularAlignment = Alignment.center;
        destPage = const SplashScreen();
      } else if (routePath == AppRoutes.searchShows) {
        circularAlignment = Alignment.topCenter;
        destPage = const SearchScreen();
      } else if (routePath == AppRoutes.favMovies) {
        circularAlignment = Alignment.topRight;
        destPage = const FavMoviesScreen();
      } else if (routePath == AppRoutes.favTVShows) {
        circularAlignment = Alignment.topRight;
        destPage = const FavTVShowsScreen();
      } else if (routePath == AppRoutes.home) {
        destPage = const HomeScreen();
      } else if (routePath == AppRoutes.nowPlayingMovieList) {
        destPage = const NowPlayingMoviesListScreen();
      } else if (routePath == AppRoutes.popularMovieList) {
        destPage = const PopularMoviesListScreen();
      } else if (routePath == AppRoutes.upcomingMovieList) {
        destPage = const UpcomingMoviesListScreen();
      } else if (routePath == AppRoutes.popularTVShowList) {
        destPage = const PopularTVShowsListScreen();
      } else if (routePath == AppRoutes.onTheAirTVShowList) {
        destPage = const OnTheAirTVShowsListScreen();
      } else if (routePath == AppRoutes.movieDetail) {
        final movieId = int.tryParse(routeUri.queryParameters['id'] ?? '-');
        if (movieId is int) {
          destPage = MovieDetailScreen(movieId: movieId);
        } else {
          destPage = const PageNotFoundScreen();
        }
      } else if (routePath == AppRoutes.tvShowDetail) {
        final tvShowId = int.tryParse(routeUri.queryParameters['id'] ?? '-');
        if (tvShowId is int) {
          destPage = TVShowDetailScreen(tvShowId: tvShowId);
        } else {
          destPage = const PageNotFoundScreen();
        }
      } else {
        destPage = const PageNotFoundScreen();
      }
    }

    if (circularAlignment == null && _pointerDownEvent != null && routeArgs is BuildContext) {
      final double dx = _pointerDownEvent!.position.dx;
      final double dy = _pointerDownEvent!.position.dy;
      final Size screenSize = MediaQuery.of(routeArgs).size;
      circularAlignment = Alignment(
        2 * dx / screenSize.width - 1,
        2 * dy / screenSize.height - 1,
      );
      useFadeTransition = true;
    }

    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => destPage,
      transitionsBuilder: (context, primaryAnimation, secondaryAnimation, page) {
        Widget transition;

        if (circularAlignment != null) {

          transition = ScaleTransition(
            alignment: circularAlignment,
            scale: primaryAnimation.drive(_defaultTweenDouble),
            child: ClipPath(
              clipper: CircularRevealClipper(
                centerAlignment: circularAlignment,
                fraction: primaryAnimation.value,
              ),
              child: page,
            ),
          );

          if (useFadeTransition) {
            transition = FadeTransition(
              opacity: primaryAnimation,
              child: transition,
            );
          }

        } else {
          final Animation<Offset> primarySlideTransitionTween = CurvedAnimation(
            parent: primaryAnimation,
            curve: Curves.linearToEaseOut,
            reverseCurve: Curves.easeInToLinear,
          ).drive(_defaultCurvedTweenOffset);

          transition = SlideTransition(
            position: primarySlideTransitionTween,
            child: FadeTransition(
              opacity: primaryAnimation,
              child: page,
            ),
          );
        }

        return transition;
      },
      settings: settings,
    );
  }
}
