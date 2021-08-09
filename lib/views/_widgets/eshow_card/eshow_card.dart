import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/models/entertainment_show/entertainment_show.dart';

final _cardStyle = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  elevation: 0.0,
  primary: Colors.grey[50],
  onPrimary: Colors.black87,
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
);

final _starIcon = Icon(
  Icons.star,
  size: 16,
  color: Colors.yellow[800],
);

final _dateFormatter = DateFormat('MMM dd, yyyy');

class EShowCard extends StatelessWidget {
  final EShow entShow;
  final VoidCallback? onTap;

  const EShowCard({
    required this.entShow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final errorImage = Center(
      child: Icon(
        Icons.error_outline,
        size: 24,
        color: Theme.of(context).errorColor,
      ),
    );

    final showTitle = Text(
      entShow.title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );

    final showRating = Text(
      entShow.rating.toStringAsFixed(1),
    );

    final movieReleaseDate = Text(
      _dateFormatter.format(DateTime.parse(entShow.releaseDate)),
      style: const TextStyle(
        color: Colors.black54,
      ),
    );

    final movieBriefDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showTitle,
        const SizedBox(height: 2),
        Row(
          children: [
            _starIcon,
            showRating,
          ],
        ),
        const SizedBox(height: 5),
        movieReleaseDate,
      ],
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: _cardStyle,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: entShow.imgUrlPoster != null
                    ? CachedNetworkImage(
                        cacheKey: entShow.id.toString(),
                        fit: BoxFit.cover,
                        imageUrl: entShow.imgUrlPosterThumb!,
                        fadeOutDuration: const Duration(milliseconds: 500),
                        maxWidthDiskCache: 400,
                        maxHeightDiskCache: 600,
                        memCacheWidth: 400,
                        memCacheHeight: 600,
                        errorWidget: (_, __, ___) => errorImage,
                      )
                    : errorImage,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: movieBriefDetails,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
