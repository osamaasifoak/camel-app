import '/core/constants/app_apis.dart';
import '/core/models/entertainment_show/entertainment_show.dart';

class Movie implements EShow {
  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.voteCount,
    required this.year,
    this.imgUrlPoster,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    final String relDate = map['release_date'] as String? ?? '';
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      releaseDate: relDate,
      rating: (map['vote_average'] as num).toDouble(),
      voteCount: map['vote_count'] as int,
      imgUrlPoster: map['poster_path'] as String?,
      year: relDate.isNotEmpty ? DateTime.parse(relDate).year.toString() : '',
    );
  }

  @override
  final int id;

  @override
  final String title;

  @override
  final String releaseDate; //release_date

  @override
  final double rating; //vote_average

  @override
  final int voteCount; //vote_count

  @override
  final String? imgUrlPoster; //poster_path

  final String year;

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
