import 'package:flutter/material.dart';

import '/core/models/eshow_section/eshow_section.dart';
import '../eshow_card/eshow_card.dart';
import '../eshow_list_view/eshow_horizontal_list_view.dart';
import '../eshow_list_view/eshow_section_button.dart';

class EShowSectionListView extends StatelessWidget {
  const EShowSectionListView({
    Key? key,
    required this.eShowSection,
    required this.onSectionTapped,
    required this.onEShowTapped,
  }) : super(key: key);

  final EShowSection eShowSection;
  final EShowCardCallback onEShowTapped;
  final VoidCallback onSectionTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EShowSectionButton(
          onTap: onSectionTapped,
          title: eShowSection.title,
        ),
        EShowHorizontalListView(
          eShows: eShowSection.eShows,
          onEShowTapped: onEShowTapped,
        ),
      ],
    );
  }
}
