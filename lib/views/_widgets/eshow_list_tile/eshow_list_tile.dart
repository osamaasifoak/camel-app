import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/models/movie/movie.dart';

final _defaultEShowListTileStyle = ElevatedButton.styleFrom(
  shadowColor: Colors.grey[50]?.withOpacity(0.3),
  elevation: 4.0,
  primary: Colors.grey[50],
  onPrimary: Colors.black87,
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

class EShowListTile extends StatelessWidget {
  final EShow eShow;
  final VoidCallback? onTap;
  final ButtonStyle? style;

  const EShowListTile({
    Key? key,
    required this.eShow,
    required this.onTap,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leadingImage = Flexible(
      flex: 0,
      child: Container(
        width: 80,
        height: 120,
        color: const Color(0xFFEEEEEE),
        child: eShow.imgUrlPoster != null
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: eShow.imgUrlPosterThumb!,
                fadeOutDuration: const Duration(milliseconds: 500),
                maxWidthDiskCache: 200,
                maxHeightDiskCache: 300,
                memCacheWidth: 200,
                memCacheHeight: 300,
                errorWidget: (_, __, ___) => Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 24,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              )
            : Center(
                child: Icon(
                  Icons.error_outline,
                  size: 24,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
    );

    final cardStyle = style ?? _defaultEShowListTileStyle;

    final Text eShowTitle;
    if (eShow is Movie) {
      final movie = eShow as Movie;
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

    final starIcon = Icon(
      Icons.star,
      size: 16,
      color: Colors.yellow[800],
    );

    final eShowRatingAndVoteCount = RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black87,
          fontFamily: 'Nunito Sans',
        ),
        children: [
          TextSpan(
            text: eShow.rating.toStringAsFixed(1),
          ),
          TextSpan(
            text: ' (${eShow.voteCount.toString()} votes)',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );

    final eShowBriefDetails = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          eShowTitle,
          const SizedBox(height: 2),
          Row(
            children: [
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
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
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
