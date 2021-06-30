import 'package:camelmovies/views/_widgets/default_shimmer.dart';
import 'package:flutter/material.dart';

class MoviesLoadingIndicator extends StatelessWidget{
  final double itemExtent;
  final int itemCount;

  const MoviesLoadingIndicator({
    Key? key,
    this.itemExtent = 200, 
    this.itemCount = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double halfScreenWidth = MediaQuery.of(context).size.width / 2;
    final double quarterScreenWidth = halfScreenWidth / 2;

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
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      elevation: 4.0,
      shadowColor: Colors.grey[50]?.withOpacity(0.3),
      color: Colors.grey[50],
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          DefaultShimmer(
            child: Container(
              width: 80, 
              height: 120, 
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,   
            children: [
              DefaultShimmer(
                child: Container(
                  width: halfScreenWidth,
                  height: 15, 
                  color: Colors.white, 
                  margin: const EdgeInsets.only(bottom: 5),
                ), 
              ),
              DefaultShimmer(
                child: Container(
                  width: quarterScreenWidth, 
                  height: 20, 
                  color: Colors.white,
                ), 
              ),
            ],
          ),
        ],
      ),
    );
  }  
}
