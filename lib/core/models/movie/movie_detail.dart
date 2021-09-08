import 'dart:convert' show json;

import '/core/constants/app_apis.dart';
import '/core/models/entertainment_show/entertainment_show_details.dart';
import '/core/models/entertainment_show/entertainment_show_genres.dart';
import 'movie.dart';

typedef ESG = EShowGenre;
typedef JsonMap = Map<String, dynamic>;

class MovieDetail extends Movie implements EShowDetails {
  const MovieDetail({
    required int id,
    required String title,
    required String releaseDate,
    required double rating,
    required int voteCount,
    required String? imgUrlPoster,
    required String year,
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
          year: year,
        );

  @override
  factory MovieDetail.fromMap(JsonMap map) {
    final List<EShowGenre> genres = (map['genres'] as List<dynamic>).map(
      (dynamic g) {
        return ESG.fromMap(g as JsonMap);
      },
    ).toList(growable: false);
    final String relDate = map['release_date'] as String? ?? '';
    return MovieDetail(
      id: map['id'] as int,
      title: map['title'] as String,
      releaseDate: relDate,
      overview: map['overview'] as String,
      rating: (map['vote_average'] as num).toDouble(),
      voteCount: map['vote_count'] as int,
      imgUrlPoster: map['poster_path'] as String?,
      imgUrlBackdrop: map['backdrop_path'] as String?,
      runtime: map['runtime'] as int,
      year: relDate.isNotEmpty ? DateTime.parse(relDate).year.toString() : '',
      genres: genres,
    );
  }

  factory MovieDetail.fromJson(String source) {
    return MovieDetail.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  final String overview; //overview
  @override
  final String? imgUrlBackdrop; //backdrop_path
  @override
  final int runtime;
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
