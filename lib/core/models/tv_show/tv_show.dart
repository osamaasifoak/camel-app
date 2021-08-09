
import 'dart:convert' show json;

import '/core/constants/app_apis.dart';
import '/core/models/entertainment_show/entertainment_show.dart';

class TVShow implements EShow {

  const TVShow({
    required this.id,
    required this.imgUrlPoster,
    required this.rating,
    required this.releaseDate,
    required this.title,
    required this.voteCount,
  });

  @override
  final int id;

  @override
  final String? imgUrlPoster;

  @override
  final double rating;

  @override
  final String releaseDate;

  @override
  final String title;

  @override
  final int voteCount;

  @override
  String? get imgUrlPosterOriginal {
    if (imgUrlPoster != null) {
      return AppApis().baseImageUrl + AppApis().epOriginalImage + imgUrlPoster!;
    }
  }

  @override
  String? get imgUrlPosterThumb {
    if (imgUrlPoster != null) {
      return AppApis().baseImageUrl + AppApis().epThumbImage + imgUrlPoster!;
    }
  }

  factory TVShow.fromMap(Map<String, dynamic> map) {
    return TVShow(
      id: map['id'] as int,
      title: map['name'] as String,
      releaseDate: map['first_air_date'] as String? ?? '--',
      rating: (map['vote_average'] as num).toDouble(),
      voteCount: map['vote_count'] as int,
      imgUrlPoster: map['poster_path'] as String?,
    );
  }

  factory TVShow.fromJson(String source) => TVShow.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TVShow(id: $id, imgUrlPoster: $imgUrlPoster, rating: $rating, releaseDate: $releaseDate, title: $title, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TVShow &&
      other.id == id &&
      other.imgUrlPoster == imgUrlPoster &&
      other.rating == rating &&
      other.releaseDate == releaseDate &&
      other.title == title &&
      other.voteCount == voteCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      imgUrlPoster.hashCode ^
      rating.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      voteCount.hashCode;
  }
}
