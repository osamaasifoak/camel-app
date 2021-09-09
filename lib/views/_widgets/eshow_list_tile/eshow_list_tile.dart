import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/core/helpers/app_cache_manager.dart';
import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/models/movie/movie.dart';

final ButtonStyle _defaultEShowListTileStyle = ElevatedButton.styleFrom(
  shadowColor: Colors.grey[50]?.withOpacity(0.3),
  elevation: 4.0,
  primary: Colors.grey[50],
  onPrimary: Colors.black87,
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

// ignore: use_late_for_private_fields_and_variables
Widget? _errorWidget;

class EShowListTile extends StatelessWidget {
  const EShowListTile({
    Key? key,
    required this.eShow,
    required this.onTap,
    this.style,
  }) : super(key: key);

  final EShow eShow;
  final VoidCallback? onTap;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final Widget eShowImage;
    if (eShow.imgUrlPoster != null) {
      eShowImage = CachedNetworkImage(
        imageUrl: eShow.imgUrlPosterThumb!,
        cacheManager: AppCacheManager(),
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 250),
        fadeOutDuration: const Duration(milliseconds: 250),
        memCacheWidth: 200,
        memCacheHeight: 300,
        maxWidthDiskCache: 200,
        maxHeightDiskCache: 300,
        errorWidget: (_, __, ___) {
          return _errorWidget ??= Center(
            child: Icon(
              Icons.error_outline,
              size: 24,
              color: Theme.of(context).errorColor,
            ),
          );
        },
      );
    } else {
      eShowImage = _errorWidget ??= Center(
        child: Icon(
          Icons.error_outline,
          size: 24,
          color: Theme.of(context).errorColor,
        ),
      );
    }
    final Widget leadingImage = Container(
      width: 80,
      height: 120,
      color: const Color(0xFFEEEEEE),
      child: eShowImage,
    );

    final ButtonStyle cardStyle = style ?? _defaultEShowListTileStyle;

    final Widget eShowTitle;
    if (eShow is Movie) {
      final Movie movie = eShow as Movie;
      final String movieTitleAndYear;
      if (movie.year.isEmpty) {
        movieTitleAndYear = movie.title;
      } else {
        movieTitleAndYear = '${movie.title} (${movie.year})';
      }
      eShowTitle = Text(
        movieTitleAndYear,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      eShowTitle = Text(
        eShow.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    const Icon starIcon = Icon(
      Icons.star,
      size: 16,
      color: Color(0xFFF9A825), // Colors.yellow[800],
    );

    final Widget eShowRatingAndVoteCount = RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black87,
          fontFamily: 'Nunito Sans',
        ),
        children: <InlineSpan>[
          TextSpan(
            text: eShow.rating.toStringAsFixed(1),
          ),
          TextSpan(
            text: ' (${eShow.voteCount} votes)',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );

    final Widget eShowBriefDetails = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          eShowTitle,
          const SizedBox(height: 2),
          Row(
            children: <Widget>[
              starIcon,
              eShowRatingAndVoteCount,
            ],
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: cardStyle,
        onPressed: onTap,
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: <Widget>[
            leadingImage,
            const SizedBox(width: 10),
            eShowBriefDetails,
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
