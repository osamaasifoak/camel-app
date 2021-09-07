import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/helpers/app_cache_manager.dart';
import '/core/models/entertainment_show/entertainment_show.dart';

final _cardStyle = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  elevation: 0.0,
  primary: Colors.grey[50],
  onPrimary: Colors.black87,
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

final _starIcon = Icon(
  Icons.star,
  size: 16,
  color: Colors.yellow[800],
);

final _dateFormatter = DateFormat('MMM dd, yyyy');

Widget? _errorWidget;

typedef EShowCardCallback = void Function(EShow eShow);

class EShowCard extends StatelessWidget {
  const EShowCard({
    Key? key,
    required this.eShow,
    required this.onTap,
  }) : super(key: key);

  final EShow eShow;
  final EShowCardCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final showTitle = Text(
      eShow.title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );

    final showRating = Text(
      eShow.rating.toStringAsFixed(1),
    );

    final eShowReleaseDate = Text(
      _dateFormatter.format(DateTime.parse(eShow.releaseDate)),
      style: const TextStyle(
        color: Colors.black54,
      ),
    );

    final eShowBriefDetails = Column(
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
        eShowReleaseDate,
      ],
    );

    final Widget eShowImage;
    if (eShow.imgUrlPoster != null) {
      eShowImage = CachedNetworkImage(
        imageUrl: eShow.imgUrlPosterThumb!,
        cacheManager: AppCacheManager(),
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 250),
        fadeOutDuration: const Duration(milliseconds: 250),
        memCacheWidth: 400,
        memCacheHeight: 600,
        maxWidthDiskCache: 400,
        maxHeightDiskCache: 600,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap != null ? () => onTap!(eShow) : null,
        style: _cardStyle,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                clipBehavior: Clip.hardEdge,
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                  color: Color(0xFFEEEEEE),
                ),
                child: eShowImage,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: eShowBriefDetails,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
