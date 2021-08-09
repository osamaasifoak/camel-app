
import 'dart:convert' show json;

class EShowGenre {
  final int id;
  final String name;
  
  const EShowGenre({
    required this.id,
    required this.name,
  });

  EShowGenre copyWith({
    int? id,
    String? name,
  }) {
    return EShowGenre(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory EShowGenre.fromMap(Map<String, dynamic> map) {
    return EShowGenre(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }


  factory EShowGenre.fromJson(String source) => EShowGenre.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EShowGenre(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EShowGenre &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}