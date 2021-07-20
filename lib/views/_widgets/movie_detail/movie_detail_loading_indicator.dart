
import 'package:camelmovies/views/_widgets/default_shimmer.dart';
import 'package:flutter/material.dart';

class MovieDetailLoadingIndicator extends StatelessWidget{
  
  const MovieDetailLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        moviePoster(screenHeight),
        movieTitle(screenWidth),
        movieTags(screenWidth),
        movieBackdropImage(screenHeight),
      ],
    );
  }

  DefaultShimmer movieBackdropImage(double screenHeight) {
    return DefaultShimmer(
      child: Container(
        height: screenHeight / 6,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
      ),
    );
  }

  Container movieTags(double screenWidth) {

    final smallTag = DefaultShimmer(
      child: Container(
        width: screenWidth / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
      ),
    );

    final midTag = DefaultShimmer(
      child: Container(   
        width: screenWidth / 4.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
      ),
    );

    return Container(
      height: 45,
      margin: const EdgeInsets.fromLTRB(10,15,10,15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          smallTag,
          midTag,
          smallTag,
        ],
      ),
    );
  }

  DefaultShimmer movieTitle(double screenWidth) {
    return DefaultShimmer(
      child: Container(
        width: screenWidth / 2,
        height: 40, 
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
      ), 
    );
  }

  AppBar moviePoster(double screenHeight) {
    return AppBar(
      elevation: 0.7,
      shadowColor: Colors.grey[100],
      flexibleSpace: DefaultShimmer(
        child: Container(
          height: screenHeight / 1.5, 
          color: Colors.white,
        ), 
      ),
    );
  }

}