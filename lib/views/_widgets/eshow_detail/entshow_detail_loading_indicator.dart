import 'package:flutter/material.dart';

import '/views/_widgets/default_shimmer.dart';

class EShowDetailLoadingIndicator extends StatelessWidget {
  const EShowDetailLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          moviePoster(screenHeight),
          movieTitle(screenWidth),
          movieTags(screenWidth),
          movieBackdropImage(screenHeight),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget movieBackdropImage(double screenHeight) {
    return NoShimmer(
      height: screenHeight * 0.167,
    );
  }

  Container movieTags(double screenWidth) {
    final Widget smallTag = NoShimmer(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      width: screenWidth * 0.33,
    );

    final Widget midTag = NoShimmer(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      width: screenWidth * 0.22,
    );

    return Container(
      height: 45,
      margin: const EdgeInsets.fromLTRB(16, 15, 16, 15),
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

  Widget movieTitle(double screenWidth) {
    return NoShimmer(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      height: 40,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      width: screenWidth * 0.5,
    );
  }

  AppBar moviePoster(double screenHeight) {
    return AppBar(
      elevation: 0,
      flexibleSpace: NoShimmer(height: screenHeight * 0.67 + kToolbarHeight / 2),
    );
  }
}
