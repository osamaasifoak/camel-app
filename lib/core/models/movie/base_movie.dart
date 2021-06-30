import 'dart:convert' show json;

class BaseMovie {
  final num? id; //id

  const BaseMovie({
    this.id,
  });

  BaseMovie copyWith({
    num? id,
  }) {
    return BaseMovie(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory BaseMovie.fromMap(Map<String, dynamic> map) {
    return BaseMovie(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseMovie.fromJson(String source) =>
      BaseMovie.fromMap(json.decode(source));

  @override
  String toString() => 'BaseMovie(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseMovie && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
