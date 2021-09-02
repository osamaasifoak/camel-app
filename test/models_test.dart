import 'dart:math';

import 'package:camelmovies/core/constants/app_apis.dart';
import 'package:camelmovies/core/models/entertainment_show/entertainment_show.dart';
import 'package:camelmovies/core/models/movie/movie.dart';
import 'package:camelmovies/core/models/movie/movie_detail.dart';
import 'package:camelmovies/core/repositories/base_eshows_repo.dart';
import 'package:camelmovies/core/repositories/movies_repo/movies_repo.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:postor/postor.dart';

const apiKey = '';

void main() {
  // prepare network service & movie repository
  GetIt.I.registerSingleton<Postor>(
    Postor(
      AppApis().baseUrl,
      defaultHeaders: AppApis().defaultHeader,
    ),
  );
  GetIt.I.registerSingleton<BaseEShowsRepository>(
    MoviesRepository(),
    instanceName: 'movies',
  );
  final moviesRepo = GetIt.I<BaseEShowsRepository>(instanceName: 'movies');

  AppApis().loadApiKey(apiKey: apiKey);
  group('Test [Movie] model: see if [Movie] can parse response.body correctly:\n', () {
    test(
        'Given user request of get now playing,\n'
        'when `BaseMoviesRepository` do getNowPlaying()\n'
        'then return an instance of `List<Movie>` consists of '
        '20 items.', () {
      expectLater(
        moviesRepo.fetch(category: MovieEndpoint.nowPlaying.name).then((movieList) {
          expect(movieList, isA<List<Movie>>());
          expect(movieList.length, equals(20));
        }),
        completes,
      );
    });
    test(
        'Given user request of get upcoming,\n'
        'when `BaseMoviesRepository` do getUpcoming()\n'
        'then return an instance of `List<Movie>` consists of '
        '20 items.', () {
      expectLater(
        moviesRepo.fetch(category: MovieEndpoint.upcoming.name).then((movieList) {
          expect(movieList, isA<List<Movie>>());
          expect(movieList.length, equals(20));
        }),
        completes,
      );
    });
    test(
        'Given user request of get now playing,\n'
        'when `BaseMoviesRepository` do getPopular()\n'
        'then return an instance of `List<Movie>` consists of '
        '20 items.', () {
      expectLater(
        moviesRepo.fetch(category: MovieEndpoint.popular.name).then((movieList) {
          expect(movieList, isA<List<Movie>>());
          expect(movieList.length, equals(20));
        }),
        completes,
      );
    });
  });
  test('Test [MovieDetail] & [MovieGenre] models: see if both can parse response.body correctly.', () async {
    late final EShow randomMovie;
    await expectLater(
      moviesRepo.fetch(category: MovieEndpoint.nowPlaying.name).then((movieList) {
        expect(movieList, isA<List<Movie>>());
        expect(movieList.length, equals(20));
        randomMovie = movieList[Random().nextInt(19)];
      }),
      completes,
    );
    expectLater(
      moviesRepo.getDetails(id: randomMovie.id).then((movieDetail) {
        expect(movieDetail, isA<MovieDetail>());
      }),
      completes,
    );
  });

  tearDownAll(() {
    GetIt.I<Postor>().cancelAll();
  });
}
