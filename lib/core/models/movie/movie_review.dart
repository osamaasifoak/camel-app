
import '/core/models/entertainment_show/entertainment_show_reviews.dart';

class MovieReview implements EShowReview {

  const MovieReview({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  final String id;

  @override
  final String  author;

  @override
  final String content;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  factory MovieReview.fromMap(Map<String, dynamic> map) {
    return MovieReview(
      id: map['id'] as String,
      author: map['author'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  @override
  String toString() {
    return 'MovieReview(id: $id, author: $author, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MovieReview &&
      other.id == id &&
      other.author == author &&
      other.content == content &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      author.hashCode ^
      content.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
