import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/core/models/movie/movie.dart';

final _defaultMovieListTileStyle = ElevatedButton.styleFrom(
          shadowColor: Colors.grey[50]?.withOpacity(0.3),
          elevation: 4.0,
          primary: Colors.grey[50],
          onPrimary: Colors.black87,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );

class MovieListTile extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onCardPressed;
  final ButtonStyle? style;

  const MovieListTile({
    Key? key,
    required this.movie,
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
        child: movie.imgUrlPoster != null
            ? CachedNetworkImage(
                cacheKey: movie.id.toString(),
                fit: BoxFit.cover,
                imageUrl: movie.imgUrlPosterThumb!,
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

    final cardStyle = style ?? _defaultMovieListTileStyle;
        
    final movieTitleAndYear = Text(
      '${movie.title} (${movie.year})',
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

    final movieRatingAndVoteCount = RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black87,
          fontFamily: 'Nunito Sans',
        ),
        children: [
          TextSpan(
            text: movie.rating.toStringAsFixed(1),
          ),
          TextSpan(
            text: ' (${movie.voteCount.toString()} votes)',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );

    final movieBriefDetails = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          movieTitleAndYear,
          const SizedBox(height: 2),
          Row(
            children: [
              starIcon,
              movieRatingAndVoteCount,
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
            movieBriefDetails,
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
