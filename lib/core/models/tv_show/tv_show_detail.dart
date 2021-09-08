import 'dart:convert' show json;

import 'package:flutter/foundation.dart';

import '/core/constants/app_apis.dart';
import '/core/models/entertainment_show/entertainment_show_details.dart';
import '/core/models/entertainment_show/entertainment_show_genres.dart';
import '/core/models/tv_show/tv_show.dart';

typedef ESG = EShowGenre;
typedef JsonMap = Map<String, dynamic>;

class TVShowDetail extends TVShow implements EShowDetails {
  const TVShowDetail({
    required int id,
    required String title,
    required String releaseDate,
    required double rating,
    required int voteCount,
    required String? imgUrlPoster,
    required this.overview,
    required this.imgUrlBackdrop,
    required this.runtime,
    required this.genres,
  }) : super(
          id: id,
          title: title,
          releaseDate: releaseDate,
          rating: rating,
          voteCount: voteCount,
          imgUrlPoster: imgUrlPoster,
        );

  @override
  factory TVShowDetail.fromMap(JsonMap map) {
    final List<EShowGenre> genres = (map['genres'] as List<dynamic>).map(
      (dynamic g) {
        return ESG.fromMap(g as JsonMap);
      },
    ).toList(growable: false);
    return TVShowDetail(
      id: map['id'] as int,
      title: map['name'] as String,
      releaseDate: map['first_air_date'] as String? ?? '--',
      rating: (map['vote_average'] as num).toDouble(),
      voteCount: map['vote_count'] as int,
      overview: map['overview'] as String,
      imgUrlPoster: map['poster_path'] as String?,
      imgUrlBackdrop: map['backdrop_path'] as String?,
      runtime: (map['episode_run_time'] as List<dynamic>).cast<int>(),
      genres: genres,
    );
  }

  @override
  factory TVShowDetail.fromJson(String source) {
    return TVShowDetail.fromMap(json.decode(source) as JsonMap);
  }

  @override
  final String overview; //overview
  @override
  final String? imgUrlBackdrop; //backdrop_path
  @override
  final List<int> runtime; //episode_runtime
  @override
  final List<ESG> genres;

  @override
  String? get imgUrlBackdropOriginal {
    if (imgUrlBackdrop != null) {
      return AppApis().baseImageUrl + AppApis().epOriginalImage + imgUrlBackdrop!;
    }
  }

  @override
  String? get imgUrlBackdropThumb {
    if (imgUrlBackdrop != null) {
      return AppApis().baseImageUrl + AppApis().epThumbImage + imgUrlBackdrop!;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TVShowDetail &&
        other.overview == overview &&
        other.imgUrlBackdrop == imgUrlBackdrop &&
        listEquals(other.runtime, runtime) &&
        listEquals(other.genres, genres);
  }

  @override
  int get hashCode {
    return overview.hashCode ^ imgUrlBackdrop.hashCode ^ runtime.hashCode ^ genres.hashCode;
  }
}
