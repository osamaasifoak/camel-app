import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/helpers/app_cache_manager.dart';
import '/core/models/entertainment_show/entertainment_show.dart';

final ButtonStyle _cardStyle = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  elevation: 0.0,
  primary: Colors.grey[50],
  onPrimary: Colors.black87,
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

const Icon _starIcon = Icon(
  Icons.star,
  size: 16,
  color: Color(0xFFF9A825), //Colors.yellow[800],
);

final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

// ignore: use_late_for_private_fields_and_variables
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
    final Widget showTitle = Text(
      eShow.title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );

    final Widget showRating = Text(
      eShow.rating.toStringAsFixed(1),
    );

    final Widget eShowReleaseDate = Text(
      _dateFormatter.format(DateTime.parse(eShow.releaseDate)),
      style: const TextStyle(
        color: Colors.black54,
      ),
    );

    final Widget eShowBriefDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        showTitle,
        const SizedBox(height: 2),
        Row(
          children: <Widget>[
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
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                clipBehavior: Clip.hardEdge,
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
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
