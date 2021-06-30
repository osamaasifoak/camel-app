import 'dart:convert' show json;

import 'package:camelmovies/core/constants/app_apis.dart';

import 'movie.dart';
import 'movie_genre.dart';

class MovieDetail extends Movie {
  final String? overview; //overview
  final String? imgUrlBackdrop; //backdrop_path
  final num? runtime;
  final String? year;
  final List<MovieGenre>? genres;

  const MovieDetail({
    num? id,
    String? title,
    String? releaseDate,
    num? rating,
    num? voteCount,
    String? imgUrlPoster,
    this.overview,
    this.imgUrlBackdrop,
    this.runtime,
    this.year,
    this.genres,
  }): super(
    id: id, 
    title: title, 
    releaseDate: releaseDate, 
    rating: rating,
    voteCount: voteCount,
    imgUrlPoster: imgUrlPoster);

  String get imgUrlBackdropOriginal {
    if (imgUrlBackdrop != null) {
      return AppApis().baseImageUrl + AppApis().epOriginalImage + imgUrlBackdrop!;
    } else {
      return AppApis().baseImageUrl + AppApis().epOriginalImage + '/null';
    }
  }

  String get imgUrlBackdropThumb {
    if (imgUrlBackdrop != null) {
      return AppApis().baseImageUrl + AppApis().epThumbImage + imgUrlBackdrop!;
    } else {
      return AppApis().baseImageUrl + AppApis().epThumbImage + '/null';
    }
  }

  @override
  MovieDetail copyWith({
    num? id,
    String? title,
    String? releaseDate,
    String? overview,
    num? rating,
    num? voteCount,
    String? imgUrlPoster,
    String? imgUrlBackdrop,
    num? runtime,
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
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'overview': overview,
      'vote_average': rating,
      'vote_count': voteCount,
      'poster_path': imgUrlPoster,
      'backdrop_path': imgUrlBackdrop,
      'runtime': runtime,
      'year': year,
      'genres': genres,
    };
  }

  @override
  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    var gen = List<Map<String, dynamic>>.from(map['genres']);
    var genres = List.generate(gen.length, (i) => 
      MovieGenre.fromMap(gen[i])
    );
    return MovieDetail(
      id: map['id'],
      title: map['title'],
      releaseDate: map['release_date'],
      overview: map['overview'].toString(),
      rating: map['vote_average'],
      voteCount: map['vote_count'],
      imgUrlPoster: map['poster_path'],
      imgUrlBackdrop: map['backdrop_path'],
      runtime: map['runtime'],
      year: DateTime.parse(map['release_date']).year.toString(),
      genres: genres,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  factory MovieDetail.fromJson(String source) => MovieDetail.fromMap(json.decode(source));

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
