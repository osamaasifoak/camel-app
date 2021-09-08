import 'package:flutter/material.dart';

import '/core/models/entertainment_show/entertainment_show.dart';
import '../eshow_card/eshow_card.dart';
import '../eshow_card/eshow_card_loading_indicator.dart';

class EShowHorizontalListView extends StatelessWidget {
  const EShowHorizontalListView({
    Key? key,
    required this.eShows,
    required this.onEShowTapped,
    this.itemExtent = 200,
  }) : super(key: key);

  final List<EShow> eShows;
  final EShowCardCallback onEShowTapped;
  final double itemExtent;

  @override
  Widget build(BuildContext context) {
    if (eShows.isEmpty) {
      return const EShowCardLoadingIndicator();
    }
    return SizedBox(
      height: 450,
      child: ListView.builder(
        physics: const PageScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return EShowCard(
            eShow: eShows[index],
            onTap: onEShowTapped,
          );
        },
        itemExtent: itemExtent,
        itemCount: eShows.length,
      ),
    );
  }
}
