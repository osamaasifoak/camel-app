
import 'dart:convert' show json;

import 'package:camelmovies/core/constants/app_apis.dart';

import 'base_movie.dart';

class Movie extends BaseMovie {
  
  final String? title; //title
  final String? releaseDate; //release_date
  final num? rating; //vote_average
  final num? voteCount; //vote_count
  final String? imgUrlPoster; //poster_path
  final String? year;
  
  const Movie({
    num? id,
    this.title,
    this.releaseDate,
    this.rating,
    this.voteCount,
    this.imgUrlPoster,
    this.year,
  }) : super(id: id,);

  String get imgUrlPosterOriginal {
    if (imgUrlPoster != null) {
      return AppApis().baseImageUrl + AppApis().epOriginalImage + imgUrlPoster!;
    } else {
      return AppApis().baseImageUrl + AppApis().epOriginalImage + '/null';
    }
  }

  String get imgUrlPosterThumb {
    if (imgUrlPoster != null) {
      return AppApis().baseImageUrl + AppApis().epThumbImage + imgUrlPoster!;
    } else {
      return AppApis().baseImageUrl + AppApis().epThumbImage + '/null';
    }
  }

  @override
  Movie copyWith({
    num? id,
    String? title,
    String? releaseDate,
    num? rating, 
    num? voteCount,
    String? imgUrlPoster,
    String? year,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      voteCount: voteCount ?? this.voteCount,
      imgUrlPoster: imgUrlPoster ?? this.imgUrlPoster,
      year: year ?? this.year,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'vote_average': rating,
      'vote_count': voteCount,
      'poster_path': imgUrlPoster,
      'year': year,
    };
  }

  @override
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'].toString(),
      releaseDate: map['release_date'].toString(),
      rating: map['vote_average'],
      voteCount: map['vote_count'],
      imgUrlPoster: map['poster_path'],
      year: DateTime.parse(map['release_date']).year.toString(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, releaseDate: $releaseDate, rating: $rating, voteCount: $voteCount, imgUrlPoster: $imgUrlPoster, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Movie &&
      other.id == id &&
      other.title == title &&
      other.releaseDate == releaseDate &&
      other.rating == rating &&
      other.voteCount == voteCount &&
      other.imgUrlPoster == imgUrlPoster &&
      other.year == year;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      releaseDate.hashCode ^
      rating.hashCode ^
      voteCount.hashCode ^
      imgUrlPoster.hashCode ^
      year.hashCode;
  }
}