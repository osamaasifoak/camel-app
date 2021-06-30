import 'dart:convert' show json;

class MovieGenre {
  final num? id;
  final String? genreName;
  
  const MovieGenre({
    this.id,
    this.genreName,
  });

  MovieGenre copyWith({
    num? id,
    String? genreName,
  }) {
    return MovieGenre(
      id: id ?? this.id,
      genreName: genreName ?? this.genreName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': genreName,
    };
  }

  factory MovieGenre.fromMap(Map<String, dynamic> map) {
    return MovieGenre(
      id: map['id'],
      genreName: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieGenre.fromJson(String source) => MovieGenre.fromMap(json.decode(source));

  @override
  String toString() => 'MovieGenre(id: $id, genreName: $genreName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MovieGenre &&
      other.id == id &&
      other.genreName == genreName;
  }

  @override
  int get hashCode => id.hashCode ^ genreName.hashCode;
}
