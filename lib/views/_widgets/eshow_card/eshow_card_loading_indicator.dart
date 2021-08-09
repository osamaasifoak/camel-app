import 'package:flutter/material.dart';

import '/views/_widgets/default_shimmer.dart';

final _cardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15),
);

final _shimmeringItemDetailDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5),
);

final _shimmeringMovieImage = Expanded(
  flex: 2,
  child: DefaultShimmer(
    child: Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ),
);

class EShowCardLoadingIndicator extends StatelessWidget {
  final double listItemExtent;
  final Size? itemSize;
  final int itemCount;
  final Axis scrollDirection;

  const EShowCardLoadingIndicator({
    Key? key,
    this.listItemExtent = 200,
    this.itemCount = 5,
    this.scrollDirection = Axis.horizontal,
    this.itemSize,
  }) : super(key: key);

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
        itemBuilder: (_, __) => shimmeringMovieCards(halfScreenWidth, quarterScreenWidth),
        itemCount: itemCount,
        itemExtent: listItemExtent,
      ),
    );
  }

  @protected
  Widget shimmeringMovieCards(double halfScreenWidth, double quarterScreenWidth) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 0,
      shadowColor: Colors.transparent,
      color: Colors.grey[50],
      clipBehavior: Clip.hardEdge,
      shape: _cardShape,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmeringMovieImage,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  DefaultShimmer(
                    child: Container(
                      width: quarterScreenWidth * 1.5,
                      height: 20,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: _shimmeringItemDetailDecoration,
                    ),
                  ),
                  // rating
                  DefaultShimmer(
                    child: Container(
                      width: quarterScreenWidth * 0.85,
                      height: 15,
                      margin: const EdgeInsets.only(bottom: 7),
                      decoration: _shimmeringItemDetailDecoration,
                    ),
                  ),
                  // release date
                  DefaultShimmer(
                    child: Container(
                      width: quarterScreenWidth,
                      height: 15,
                      decoration: _shimmeringItemDetailDecoration,
                    ),
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
