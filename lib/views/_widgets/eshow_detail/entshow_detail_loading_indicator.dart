import 'package:flutter/material.dart';

import '/core/helpers/screen_sizer.dart';
import '/views/_widgets/default_shimmer.dart';

class EShowDetailLoadingIndicator extends StatelessWidget {
  const EShowDetailLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          eShowPoster,
          eShowTitle,
          eShowTags,
          eShowBackdropImage,
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget get eShowBackdropImage {
    return NoShimmer(height: ScreenSizer().currentHeight * 0.167);
  }

  Widget get eShowTags {
    final Widget smallTag = NoShimmer(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      width: ScreenSizer().currentWidth * 0.33,
    );

    final Widget midTag = NoShimmer(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      width: ScreenSizer().currentWidth * 0.22,
    );

    return Container(
      height: 45,
      margin: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          smallTag,
          midTag,
          smallTag,
        ],
      ),
    );
  }

  Widget get eShowTitle {
    return NoShimmer(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      height: 40,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      width: ScreenSizer().currentWidth * 0.5,
    );
  }

  AppBar get eShowPoster {
    return AppBar(
      elevation: 0,
      flexibleSpace: NoShimmer(
        height: ScreenSizer().currentHeight * 0.67 + kToolbarHeight / 2,
      ),
    );
  }
}
