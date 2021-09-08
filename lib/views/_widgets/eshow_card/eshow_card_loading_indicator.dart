import 'package:flutter/material.dart';

import '/views/_widgets/default_shimmer.dart';

const ShapeBorder _cardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(15)),
);

const BorderRadius _itemDetaiBorderRadius = BorderRadius.all(
  Radius.circular(5),
);

class EShowCardLoadingIndicator extends StatelessWidget {
  const EShowCardLoadingIndicator({
    Key? key,
    this.listItemExtent = 200,
    this.itemCount = 5,
    this.scrollDirection = Axis.horizontal,
    this.itemSize,
  }) : super(key: key);

  final double listItemExtent;
  final Size? itemSize;
  final int itemCount;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    final double halfScreenWidth = MediaQuery.of(context).size.width * 0.5;
    final double quarterScreenWidth = halfScreenWidth * 0.5;

    return SizedBox(
      height: itemSize?.height ?? listItemExtent * 2.25,
      width: itemSize?.width,
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: scrollDirection,
        shrinkWrap: true,
        itemBuilder: (_, __) =>
            shimmeringMovieCards(halfScreenWidth, quarterScreenWidth),
        itemCount: itemCount,
        itemExtent: listItemExtent,
      ),
    );
  }

  @protected
  Widget shimmeringMovieCards(
      double halfScreenWidth, double quarterScreenWidth) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 0,
      shadowColor: Colors.transparent,
      color: Colors.grey[50],
      clipBehavior: Clip.hardEdge,
      shape: _cardShape,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // movie image
          const Expanded(
            flex: 2,
            child: NoShimmer(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // title
                  NoShimmer(
                    borderRadius: _itemDetaiBorderRadius,
                    height: 20,
                    padding: const EdgeInsets.only(bottom: 5),
                    width: quarterScreenWidth * 1.5,
                  ),
                  // rating
                  NoShimmer(
                    borderRadius: _itemDetaiBorderRadius,
                    height: 15,
                    padding: const EdgeInsets.only(bottom: 7),
                    width: quarterScreenWidth * 0.85,
                  ),
                  // release date
                  NoShimmer(
                    height: 15,
                    borderRadius: _itemDetaiBorderRadius,
                    width: quarterScreenWidth,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
