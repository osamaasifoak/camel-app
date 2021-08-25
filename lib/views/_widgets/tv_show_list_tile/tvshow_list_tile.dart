import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/core/models/tv_show/tv_show.dart';

final _defaultTVShowListTileStyle = ElevatedButton.styleFrom(
          shadowColor: Colors.grey[50]?.withOpacity(0.3),
          elevation: 4.0,
          primary: Colors.grey[50],
          onPrimary: Colors.black87,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );

class TVShowListTile extends StatelessWidget {
  final TVShow tvShow;
  final VoidCallback? onCardPressed;
  final ButtonStyle? style;

  const TVShowListTile({
    Key? key,
    required this.tvShow,
    required this.onCardPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorImage = Center(
      child: Icon(
        Icons.error_outline,
        size: 24,
        color: Theme.of(context).errorColor,
      ),
    );
    final leadingImage = Flexible(
      flex: 0,
      child: Container(
        width: 80,
        height: 120,
        color: Colors.white70,
        child: tvShow.imgUrlPoster != null
            ? CachedNetworkImage(
                cacheKey: tvShow.id.toString(),
                fit: BoxFit.cover,
                imageUrl: tvShow.imgUrlPosterThumb!,
                fadeOutDuration: const Duration(milliseconds: 500),
                maxWidthDiskCache: 200,
                maxHeightDiskCache: 300,
                memCacheWidth: 200,
                memCacheHeight: 300,
                errorWidget: (_, __, ___) => errorImage,
              )
            : errorImage,
      ),
    );

    final cardStyle = style ?? _defaultTVShowListTileStyle;

    final tvShowTitleAndYear = Text(
      tvShow.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

    final starIcon = Icon(
      Icons.star,
      size: 16,
      color: Colors.yellow[800],
    );

    final tvShowRatingAndVoteCount = RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black87,
          fontFamily: 'Nunito Sans',
        ),
        children: [
          TextSpan(
            text: tvShow.rating.toStringAsFixed(1),
          ),
          TextSpan(
            text: ' (${tvShow.voteCount.toString()} votes)',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );

    final tvShowBriefDetails = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tvShowTitleAndYear,
          const SizedBox(height: 2),
          Row(
            children: [
              starIcon,
              tvShowRatingAndVoteCount,
            ],
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: cardStyle,
        onPressed: onCardPressed,
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            leadingImage,
            const SizedBox(width: 10),
            tvShowBriefDetails,
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
