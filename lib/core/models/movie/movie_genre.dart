import 'dart:convert' show json;

class MovieGenre {
  final int id;
  final String genreName;
  
  const MovieGenre({
    required this.id,
    required this.genreName,
  });

  MovieGenre copyWith({
    int? id,
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
      id: map['id'] as int,
      genreName: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieGenre.fromJson(String source) => MovieGenre.fromMap(json.decode(source) as Map<String, dynamic>);

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
