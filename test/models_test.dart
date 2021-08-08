import 'dart:math';

import 'package:camelmovies/core/constants/app_apis.dart';
import 'package:camelmovies/core/models/movie/movie.dart';
import 'package:camelmovies/core/models/movie/movie_detail.dart';
import 'package:camelmovies/core/repositories/movies_repo/base_movies_repo.dart';
import 'package:camelmovies/core/repositories/movies_repo/movies_repo.dart';
import 'package:camelmovies/core/services/network_service/base_network_service.dart';
import 'package:camelmovies/core/services/network_service/network_service.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

const apiKey = '';

Future<void> main() async{
  // prepare network service & movie repository
  GetIt.I.registerSingleton<BaseNetworkService>(NetworkService());
  GetIt.I.registerSingleton<BaseMoviesRepository>(MoviesRepository());
  final moviesRepo = GetIt.I<BaseMoviesRepository>();
  await AppApis().loadApiKey(apiKey: apiKey);
  test('Test [Movie] model: see if [Movie] can parse response.body correctly', () {
    expectLater(
      moviesRepo.getNowPlaying().then((movieList) {
        expect(movieList, isA<List<Movie>>());
        expect(movieList.length, equals(20));
      }),
      completes,
    );
  });
  test('Test [MovieDetail] & [MovieGenre] models: see if both can parse response.body correctly', () async {
    late final Movie randomMovie;
    await expectLater(
      moviesRepo.getNowPlaying().then((movieList) {
        expect(movieList, isA<List<Movie>>());
        expect(movieList.length, equals(20));
        randomMovie = movieList[Random().nextInt(19)];
      }),
      completes,
    );
    expectLater(
      moviesRepo.getMovieDetail(randomMovie.id).then((movieDetail) {
        expect(movieDetail, isA<MovieDetail>());
      }),
      completes,
    );
  });

  tearDownAll(() {
    GetIt.I<BaseNetworkService>().close();
  });
}
