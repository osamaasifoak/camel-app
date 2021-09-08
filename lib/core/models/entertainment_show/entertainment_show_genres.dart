import 'dart:convert' show json;

class EShowGenre {
  const EShowGenre({
    required this.id,
    required this.name,
  });

  factory EShowGenre.fromMap(Map<String, dynamic> map) {
    return EShowGenre(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  factory EShowGenre.fromJson(String source) {
    return EShowGenre.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  final int id;
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EShowGenre && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
