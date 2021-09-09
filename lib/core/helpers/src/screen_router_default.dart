import 'dart:developer' as _dev show log;
import 'dart:math' as math show pow;

import 'package:flutter/material.dart';

import '/core/constants/app_routes.dart';
import '/views/_widgets/circular_reveal_clipper.dart';
import '/views/details/movie_detail_screen.dart';
import '/views/details/tvshow_detail_screen.dart';
import '/views/favourites/fav_movies_screen.dart';
import '/views/favourites/fav_tvshows_screen.dart';
import '/views/home/screen/_home_screen.dart';
import '/views/movie_list_screens/now_playing_screen.dart';
import '/views/movie_list_screens/popular_list_screen.dart';
import '/views/movie_list_screens/upcoming_list_screen.dart';
import '/views/page_not_found_screen.dart';
import '/views/search/screen/_search_screen.dart';
import '/views/splash_screen.dart';
import '/views/tv_show_list_screens/on_the_air_screen.dart';
import '/views/tv_show_list_screens/popular_tv_show_screen.dart';

const void Function(String message) _log = _dev.log;

const int charCodeOf0 = 48;
const int charCodeOf9 = 57;

const double _defaultTweenDoubleBegin = 0.0;
const double _defaultTweenDoubleEnd = 1.0;
const Curve _defaultTweenDoubleCurve = Curves.fastLinearToSlowEaseIn;

final Animatable<Offset> _defaultTweenOffset = Tween<Offset>(
  begin: _defaultTweenOffsetBegin,
  end: _defaultTweenOffsetEnd,
);

const Offset _defaultTweenOffsetBegin = Offset(1.0, 0.0);
const Offset _defaultTweenOffsetEnd = Offset.zero;
const Curve _defaultTweenOffsetCurve = Curves.easeIn;

final Animatable<double> _defaultTweenDouble = Tween<double>(
  begin: _defaultTweenDoubleBegin,
  end: _defaultTweenDoubleEnd,
).chain(CurveTween(curve: _defaultTweenDoubleCurve));

final Animatable<Offset> _defaultCurvedTweenOffset = _defaultTweenOffset.chain(
  CurveTween(curve: _defaultTweenOffsetCurve),
);

int? _tryParseInt(final String? source) {
  if (source == null) return null;

  final int sourceLength = source.length;
  final int indexLength = sourceLength - 1;

  int result = 0;
  for (int i = 0; i < sourceLength; i++) {
    final int currentCharCode = source.codeUnitAt(i);
    if (currentCharCode >= charCodeOf0 && currentCharCode <= charCodeOf9) {
      final int currentValue = currentCharCode - charCodeOf0;
      result += currentValue * math.pow(10, indexLength - i).toInt();
    } else {
      return null;
    }
  }

  return result;
}

class ScreenRouter<T> extends PageRoute<T> {
  ScreenRouter({
    required RouteSettings settings,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog) {
    final String? routeName = settings.name;
    final Object? routeArgs = settings.arguments;
    Widget? destPage;

    if (routeName != null) {
      final Uri routeUri = Uri.parse(routeName);
      final String routePath = routeUri.path;

      switch (routePath) {
        case AppRoutes.splash:
          _circularAlignment = Alignment.center;
          destPage = const SplashScreen();
          break;

        case AppRoutes.searchShows:
          _circularAlignment = Alignment.topCenter;
          destPage = const SearchScreen();
          break;

        case AppRoutes.favMovies:
          _circularAlignment = Alignment.topRight;
          destPage = const FavMoviesScreen();
          break;

        case AppRoutes.favTVShows:
          _circularAlignment = Alignment.topRight;
          destPage = const FavTVShowsScreen();
          break;

        case AppRoutes.home:
          destPage = const HomeScreen();
          break;

        case AppRoutes.nowPlayingMovieList:
          destPage = const NowPlayingMoviesListScreen();
          break;

        case AppRoutes.popularMovieList:
          destPage = const PopularMoviesListScreen();
          break;

        case AppRoutes.upcomingMovieList:
          destPage = const UpcomingMoviesListScreen();
          break;

        case AppRoutes.popularTVShowList:
          destPage = const PopularTVShowsListScreen();
          break;

        case AppRoutes.onTheAirTVShowList:
          destPage = const OnTheAirTVShowsListScreen();
          break;

        case AppRoutes.movieDetail:
          final int? movieId = _tryParseInt(routeUri.queryParameters['id']);
          if (movieId is int) {
            destPage = MovieDetailScreen(movieId: movieId);
          }
          break;

        case AppRoutes.tvShowDetail:
          final int? tvShowId = _tryParseInt(routeUri.queryParameters['id']);
          if (tvShowId is int) {
            destPage = TVShowDetailScreen(tvShowId: tvShowId);
          }
          break;
      }
    }

    // ignore: prefer_const_constructors
    _destinationPage = destPage ?? PageNotFoundScreen();

    if (_circularAlignment == null && _pointerDownEvent != null && routeArgs is BuildContext) {
      final double dx = _pointerDownEvent!.position.dx;
      final double dy = _pointerDownEvent!.position.dy;
      final Size screenSize = MediaQuery.of(routeArgs).size;
      _circularAlignment = Alignment(
        2 * dx / screenSize.width - 1,
        2 * dy / screenSize.height - 1,
      );
      _useFadeTransition = true;
    }
  }

  static PointerDownEvent? _pointerDownEvent;

  static void onPointerDownEvent(PointerDownEvent newPointerDownEvent) {
    _log(newPointerDownEvent.toString());
    _pointerDownEvent = newPointerDownEvent;
  }

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  late final Widget _destinationPage;

  Alignment? _circularAlignment;

  bool _useFadeTransition = false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _destinationPage;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Widget transition;

    if (_circularAlignment != null) {
      transition = ScaleTransition(
        alignment: _circularAlignment!,
        scale: animation.drive(_defaultTweenDouble),
        child: ClipPath(
          clipper: CircularRevealClipper(
            centerAlignment: _circularAlignment,
            fraction: animation.value,
          ),
          child: child,
        ),
      );

      if (_useFadeTransition) {
        transition = FadeTransition(
          opacity: animation,
          child: transition,
        );
      }
    } else {
      final Animation<Offset> primarySlideTransitionTween = CurvedAnimation(
        parent: animation,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.easeInToLinear,
      ).drive(_defaultCurvedTweenOffset);

      transition = SlideTransition(
        position: primarySlideTransitionTween,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    }

    return transition;
  }
}
