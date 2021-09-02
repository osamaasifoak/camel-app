import '/core/repositories/base_eshows_repo.dart';

class EShowSectionProvider {

  const EShowSectionProvider({
    required this.title,
    required this.category,
  });

  /// the title that will be shown on screen
  final String title;
  /// the category for fetching from [BaseEShowsRepository.fetch]
  final String category;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EShowSectionProvider &&
      other.title == title &&
      other.category == category;
  }

  @override
  int get hashCode => title.hashCode ^ category.hashCode;
}
