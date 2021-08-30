import 'package:flutter/material.dart';

import '/views/_widgets/default_shimmer.dart';

final _cardShadowColor = Colors.grey[50]?.withOpacity(0.3);

const _cardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

// final _shimmeringItemImageContainer = DefaultShimmer(
//   child: Container(
//     width: 80,
//     height: 120,
//     color: Colors.white,
//   ),
// );

// final _shimmeringItemDetailDecoration = BoxDecoration(
//   color: Colors.white,
//   borderRadius: BorderRadius.circular(7.5),
// );

class EShowListLoadingIndicator extends StatelessWidget {
  const EShowListLoadingIndicator({
    Key? key,
    this.itemExtent = 120,
    this.itemCount = 4,
    this.withCustomScrollView = false,
    this.keyboardDismissBehavior,
  }) : super(key: key);

  final double itemExtent;
  final int itemCount;
  final bool withCustomScrollView;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    final double halfScreenWidth = MediaQuery.of(context).size.width * 0.5;
    final double quarterScreenWidth = halfScreenWidth * 0.5;

    if (withCustomScrollView) {
      return CustomScrollView(
        keyboardDismissBehavior: keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverFixedExtentList(
            itemExtent: itemExtent,
            delegate: SliverChildBuilderDelegate(
              (_, __) => _card(halfScreenWidth, quarterScreenWidth),
              childCount: itemCount,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      );
    }

    return SliverFixedExtentList(
      itemExtent: itemExtent,
      delegate: SliverChildBuilderDelegate(
        (_, __) => _card(halfScreenWidth, quarterScreenWidth),
        childCount: itemCount,
      ),
    );
  }

  Card _card(double halfScreenWidth, double quarterScreenWidth) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      elevation: 4.0,
      shadowColor: _cardShadowColor,
      color: Colors.grey[50],
      clipBehavior: Clip.hardEdge,
      shape: _cardShape,
      child: Row(
        children: [
          // item image
          const NoShimmer(
            width: 80,
            height: 120,
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoShimmer(
                borderRadius: const BorderRadius.all(Radius.circular(7.5)),
                height: 20,
                padding: const EdgeInsets.only(bottom: 5),
                width: halfScreenWidth,
              ),
              NoShimmer(
                borderRadius: const BorderRadius.all(Radius.circular(7.5)),
                width: quarterScreenWidth,
                height: 17.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
