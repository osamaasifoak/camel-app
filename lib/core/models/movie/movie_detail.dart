import 'dart:convert' show json;

import '/core/constants/app_apis.dart';

import 'movie.dart';
import 'movie_genre.dart';

class MovieDetail extends Movie {
  final String? overview; //overview
  final String? imgUrlBackdrop; //backdrop_path
  final int? runtime;
  final List<MovieGenre>? genres;

  const MovieDetail({
    required int id,
    String? title,
    String? releaseDate,
    double? rating,
    int? voteCount,
    String? imgUrlPoster,
    String? year,
    this.overview,
    this.imgUrlBackdrop,
    this.runtime,
    this.genres,
  }) : super(
          id: id,
          title: title,
          releaseDate: releaseDate,
          rating: rating,
          voteCount: voteCount,
          imgUrlPoster: imgUrlPoster,
          year: year,
        );

  String? get imgUrlBackdropOriginal {
    if (imgUrlBackdrop != null) {
      return AppApis().baseImageUrl + AppApis().epOriginalImage + imgUrlBackdrop!;
    }
  }

  String? get imgUrlBackdropThumb {
    if (imgUrlBackdrop != null) {
      return AppApis().baseImageUrl + AppApis().epThumbImage + imgUrlBackdrop!;
    }
  }

  @override
  MovieDetail copyWith({
    int? id,
    String? title,
    String? releaseDate,
    String? overview,
    double? rating,
    int? voteCount,
    String? imgUrlPoster,
    String? imgUrlBackdrop,
    int? runtime,
    String? year,
    List<MovieGenre>? genres,
  }) {
    return MovieDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      overview: overview ?? this.overview,
      rating: rating ?? this.rating,
      voteCount: voteCount ?? this.voteCount,
      imgUrlPoster: imgUrlPoster ?? this.imgUrlPoster,
      imgUrlBackdrop: imgUrlBackdrop ?? this.imgUrlBackdrop,
      runtime: runtime ?? this.runtime,
      year: year ?? this.year,
      genres: genres ?? this.genres,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'overview': overview,
      'backdrop_path': imgUrlBackdrop,
      'runtime': runtime,
      'genres': genres,
    };
  }

  @override
  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    final genres = (map['genres'] as List)
        .map(
          (g) => MovieGenre.fromMap(g as Map<String, dynamic>),
        )
        .toList(growable: false);
    return MovieDetail(
      id: map['id'] as int,
      title: map['title'] as String,
      releaseDate: map['release_date'] as String,
      overview: map['overview'] as String,
      rating: (map['vote_average'] as num).toDouble(),
      voteCount: map['vote_count'] as int,
      imgUrlPoster: map['poster_path'] as String?,
      imgUrlBackdrop: map['backdrop_path'] as String?,
      runtime: map['runtime'] as int,
      year: DateTime.parse(map['release_date'] as String).year.toString(),
      genres: genres,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  factory MovieDetail.fromJson(String source) => MovieDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MovieDetail(id: $id, title: $title, releaseDate: $releaseDate, overview: $overview, rating: $rating, voteCount: $voteCount, imgUrlPoster: $imgUrlPoster, imgUrlBackdrop: $imgUrlBackdrop, runtime: $runtime, year: $year, genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieDetail &&
        other.id == id &&
        other.title == title &&
        other.releaseDate == releaseDate &&
        other.overview == overview &&
        other.rating == rating &&
        other.voteCount == voteCount &&
        other.imgUrlPoster == imgUrlPoster &&
        other.imgUrlBackdrop == imgUrlBackdrop &&
        other.runtime == runtime &&
        other.year == year &&
        other.genres == genres;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        releaseDate.hashCode ^
        overview.hashCode ^
        rating.hashCode ^
        voteCount.hashCode ^
        imgUrlPoster.hashCode ^
        imgUrlBackdrop.hashCode ^
        runtime.hashCode ^
        year.hashCode ^
        genres.hashCode;
  }
}
