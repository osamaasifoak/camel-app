import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/core/models/entertainment_show/entertainment_show.dart';
import '../eshow_card/eshow_card.dart';
import '../eshow_card/eshow_card_loading_indicator.dart';

class EShowHorizontalListView extends StatefulWidget {
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
  State<EShowHorizontalListView> createState() => _EShowHorizontalListViewState();
}

class _EShowHorizontalListViewState extends State<EShowHorizontalListView> {
  final ScrollController _eShowListController = ScrollController();

  @override
  void dispose() {
    _eShowListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.eShows.isEmpty) {
      return const EShowCardLoadingIndicator(itemCount: 8);
    }

    Widget eShowList;
    if (kIsWeb) {
      eShowList = ListView.builder(
        controller: _eShowListController,
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return EShowCard(
            eShow: widget.eShows[index],
            onTap: widget.onEShowTapped,
          );
        },
        itemExtent: widget.itemExtent,
        itemCount: widget.eShows.length,
      );
    } else {
      eShowList = ListView.builder(
        controller: _eShowListController,
        physics: const PageScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return EShowCard(
            eShow: widget.eShows[index],
            onTap: widget.onEShowTapped,
          );
        },
        itemExtent: widget.itemExtent,
        itemCount: widget.eShows.length,
      );
    }

    if (kIsWeb) {
      eShowList = Scrollbar(
        controller: _eShowListController,
        interactive: true,
        isAlwaysShown: true,
        showTrackOnHover: true,
        hoverThickness: 8.0,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: eShowList,
      );
    }

    return SizedBox(
      height: 450,
      child: eShowList,
    );
  }
}
