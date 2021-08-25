import 'package:flutter/material.dart';

import '/views/_widgets/default_shimmer.dart';

final _cardShadowColor = Colors.grey[50]?.withOpacity(0.3);

final _cardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
);

final _shimmeringItemImageContainer = DefaultShimmer(
  child: Container(
    width: 80,
    height: 120,
    color: Colors.white,
  ),
);

final _shimmeringItemDetailDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(7.5),
);

@Deprecated('This is duplicate. Use [EShowListLoadingIndicator] instead')
class TVShowListLoadingIndicator extends StatelessWidget {
  final double itemExtent;
  final int itemCount;

  @Deprecated('This is duplicate. Use [EShowListLoadingIndicator] instead')
  const TVShowListLoadingIndicator({
    Key? key,
    this.itemExtent = 200,
    this.itemCount = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double halfScreenWidth = MediaQuery.of(context).size.width * 0.5;
    final double quarterScreenWidth = halfScreenWidth * 0.5;

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
          _shimmeringItemImageContainer,
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultShimmer(
                child: Container(
                  width: halfScreenWidth,
                  height: 20,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: _shimmeringItemDetailDecoration,
                ),
              ),
              DefaultShimmer(
                child: Container(
                  width: quarterScreenWidth,
                  height: 17.5,
                  decoration: _shimmeringItemDetailDecoration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
