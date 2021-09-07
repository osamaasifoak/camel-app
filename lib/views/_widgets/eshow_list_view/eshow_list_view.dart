import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../default_refresh_indicator_builder.dart';
import '../eshow_list_tile/eshow_list_loading_indicator.dart';
import '../eshow_list_tile/eshow_list_tile.dart';
import '/core/models/entertainment_show/entertainment_show.dart';

class EShowListView extends StatelessWidget {
  const EShowListView({
    Key? key,
    required this.eShows,
    required this.onRefresh,
    required this.onEShowTapped,
    required this.isLoadingMore,
    required this.listScrollController,
    this.addAutomaticKeepAlives = true,
    this.listPadding,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) : super(key: key);

  final Future<void> Function() onRefresh;
  final void Function(int eShowId) onEShowTapped;
  final bool isLoadingMore;
  final List<EShow> eShows;
  final bool addAutomaticKeepAlives;
  final EdgeInsetsGeometry? listPadding;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final ScrollController listScrollController;

  Widget _eShowListTileBuilder(BuildContext context, int index) {
    final eShow = eShows[index];
    return EShowListTile(
      eShow: eShow,
      onTap: () => onEShowTapped(eShow.id),
    );
  }

  Widget get _loadingMoreIndicator {
    if (isLoadingMore) {
      return const EShowListLoadingIndicator(itemCount: 5);
    } else {
      return const SliverToBoxAdapter(child: SizedBox(height: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: keyboardDismissBehavior,
      controller: listScrollController,
      cacheExtent: 200,
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
          builder: defaultRefreshIndicatorBuilder,
        ),
        SliverPadding(
          padding: listPadding ?? const EdgeInsets.fromLTRB(15, 20, 15, 0),
          sliver: SliverFixedExtentList(
            itemExtent: 120,
            delegate: SliverChildBuilderDelegate(
              _eShowListTileBuilder,
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              childCount: eShows.length,
            ),
          ),
        ),
        _loadingMoreIndicator,
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
