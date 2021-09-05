import 'dart:developer' as _dev show log;
import 'dart:math' as math show pow;

import 'package:flutter/material.dart';

import '/core/constants/app_routes.dart';
import '/views/_widgets/circular_reveal_clipper.dart';
import '/views/favourites/fav_movies_screen.dart' deferred as _fav_movies show FavMoviesScreen;
import '/views/favourites/fav_tvshows_screen.dart' deferred as _fav_tv_show show FavTVShowsScreen;
import '/views/home/screen/_home_screen.dart' deferred as _home show HomeScreen;
import '/views/movie_list_screens/now_playing_screen.dart' deferred as _list_now_playing_movie show NowPlayingMoviesListScreen;
import '/views/movie_list_screens/popular_list_screen.dart' deferred as _list_popular_movie show PopularMoviesListScreen;
import '/views/movie_list_screens/upcoming_list_screen.dart' deferred as _list_upcoming_movie show UpcomingMoviesListScreen;
import '/views/moviedetail/screen/_moviedetail_screen.dart' deferred as _details_movie show MovieDetailScreen;
import '/views/page_not_found_screen.dart' deferred as _not_found show PageNotFoundScreen;
import '/views/search/screen/_search_screen.dart' deferred as _search show SearchScreen;
import '/views/splash_screen.dart' deferred as _splash show SplashScreen;
import '/views/tv_show_detail/screen/_tvshowdetail_screen.dart' deferred as _details_tv_show show TVShowDetailScreen;
import '/views/tv_show_list_screens/on_the_air_screen.dart' deferred as _list_on_the_air_tv_show show OnTheAirTVShowsListScreen;
import '/views/tv_show_list_screens/popular_tv_show_screen.dart' deferred as _list_popular_tv_show show PopularTVShowsListScreen;

const _log = _dev.log;

const int _charCodeOf0 = 48;
const int _charCodeOf9 = 57;

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
    if (currentCharCode >= _charCodeOf0 && currentCharCode <= _charCodeOf9) {
      final int currentValue = currentCharCode - _charCodeOf0;
      result += currentValue * math.pow(10, indexLength - i).toInt();
    } else {
      return null;
    }
  }

  return result;
}

class ScreenRouter<T> extends PageRoute<T> {
  static PointerDownEvent? _pointerDownEvent;

  static void onPointerDownEvent(PointerDownEvent newPointerDownEvent) {
    _log(newPointerDownEvent.toString());
    _pointerDownEvent = newPointerDownEvent;
  }

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
          destPage = _DeferredWidget(
            loadLibraryFunc: _splash.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _splash.SplashScreen(),
          );
          break;

        case AppRoutes.searchShows:
          _circularAlignment = Alignment.topCenter;
          destPage = _DeferredWidget(
            loadLibraryFunc: _search.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _search.SearchScreen(),
          );
          break;

        case AppRoutes.favMovies:
          _circularAlignment = Alignment.topRight;
          destPage = _DeferredWidget(
            loadLibraryFunc: _fav_movies.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _fav_movies.FavMoviesScreen(),
          );
          break;

        case AppRoutes.favTVShows:
          _circularAlignment = Alignment.topRight;
          destPage = _DeferredWidget(
            loadLibraryFunc: _fav_tv_show.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _fav_tv_show.FavTVShowsScreen(),
          );
          break;

        case AppRoutes.home:
          destPage = _DeferredWidget(
            loadLibraryFunc: _home.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _home.HomeScreen(),
          );
          break;

        case AppRoutes.nowPlayingMovieList:
          destPage = _DeferredWidget(
            loadLibraryFunc: _list_now_playing_movie.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _list_now_playing_movie.NowPlayingMoviesListScreen(),
          );
          break;

        case AppRoutes.popularMovieList:
          destPage = _DeferredWidget(
            loadLibraryFunc: _list_popular_movie.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _list_popular_movie.PopularMoviesListScreen(),
          );
          break;

        case AppRoutes.upcomingMovieList:
          destPage = _DeferredWidget(
            loadLibraryFunc: _list_upcoming_movie.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _list_upcoming_movie.UpcomingMoviesListScreen(),
          );
          break;

        case AppRoutes.popularTVShowList:
          destPage = _DeferredWidget(
            loadLibraryFunc: _list_popular_tv_show.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _list_popular_tv_show.PopularTVShowsListScreen(),
          );
          break;

        case AppRoutes.onTheAirTVShowList:
          destPage = _DeferredWidget(
            loadLibraryFunc: _list_on_the_air_tv_show.loadLibrary,
            // ignore: prefer_const_constructors
            destinationPageFunc: () => _list_on_the_air_tv_show.OnTheAirTVShowsListScreen(),
          );
          break;

        case AppRoutes.movieDetail:
          final int? movieId = _tryParseInt(routeUri.queryParameters['id']);
          if (movieId is int) {
            destPage = _DeferredWidget(
              loadLibraryFunc: _details_movie.loadLibrary,
              destinationPageFunc: () {
                return _details_movie.MovieDetailScreen(movieId: movieId);
              },
            );
          }
          break;

        case AppRoutes.tvShowDetail:
          final int? tvShowId = _tryParseInt(routeUri.queryParameters['id']);
          if (tvShowId is int) {
            destPage = _DeferredWidget(
              loadLibraryFunc: _details_tv_show.loadLibrary,
              destinationPageFunc: () {
                return _details_tv_show.TVShowDetailScreen(tvShowId: tvShowId);
              },
            );
          }
          break;
      }
    }

    _destinationPage = destPage ??
        _DeferredWidget(
          loadLibraryFunc: _not_found.loadLibrary,
          // ignore: prefer_const_constructors
          destinationPageFunc: () => _not_found.PageNotFoundScreen(),
        );

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
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
    Widget page,
  ) {
    Widget transition;

    if (_circularAlignment != null) {
      transition = ScaleTransition(
        alignment: _circularAlignment!,
        scale: primaryAnimation.drive(_defaultTweenDouble),
        child: ClipPath(
          clipper: CircularRevealClipper(
            centerAlignment: _circularAlignment,
            fraction: primaryAnimation.value,
          ),
          child: page,
        ),
      );

      if (_useFadeTransition) {
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
  }
}

class _DeferredWidget extends StatefulWidget {
  const _DeferredWidget({
    Key? key,
    required this.loadLibraryFunc,
    required this.destinationPageFunc,
    this.pageLoadingIndicator,
  }) : super(key: key);

  final Future<dynamic> Function() loadLibraryFunc;

  final Widget Function() destinationPageFunc;

  final Widget? pageLoadingIndicator;

  @override
  _DeferredWidgetState createState() => _DeferredWidgetState();
}

class _DeferredWidgetState extends State<_DeferredWidget> {
  Widget? _destinationPage;

  @override
  void dispose() {
    _destinationPage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_destinationPage != null) {
      return _destinationPage!;
    }

    final Widget loadingIndicator;

    if (widget.pageLoadingIndicator != null) {
      loadingIndicator = widget.pageLoadingIndicator!;
    } else {
      loadingIndicator = Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.3,
            ),
            child: const LinearProgressIndicator(),
          ),
        ),
      );
    }

    return FutureBuilder(
      future: widget.loadLibraryFunc(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _destinationPage = widget.destinationPageFunc();
          return _destinationPage!;
        }
        return loadingIndicator;
      },
    );
  }
}
