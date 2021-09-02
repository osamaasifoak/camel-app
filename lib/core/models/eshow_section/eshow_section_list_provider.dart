import 'package:flutter/widgets.dart';
import 'eshow_section_provider.dart';

class EShowSectionListProvider extends EShowSectionProvider {
  /// Creates an [EShowSectionListProvider] for showing
  /// horizontal list view consisting of [EShow]s
  /// 
  /// [title] wil be shown on top of the list view
  /// 
  /// [category] is the endpoint to fetch the list
  /// 
  /// [onSectionTapped] is the callback for when the [title]
  /// gets tapped
  const EShowSectionListProvider({
    required String title,
    required String category,
    required this.onSectionTapped,
  }) : super(category: category, title: title,);

  final void Function(BuildContext context) onSectionTapped;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EShowSectionListProvider &&
      other.onSectionTapped == onSectionTapped;
  }

  @override
  int get hashCode => onSectionTapped.hashCode;
}
