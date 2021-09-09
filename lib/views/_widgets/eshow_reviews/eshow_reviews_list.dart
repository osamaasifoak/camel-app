import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/constants/app_colors.dart';
import '/core/models/entertainment_show/entertainment_show_reviews.dart';

final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

class EShowReviewsList extends StatelessWidget {
  const EShowReviewsList({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  final List<EShowReview> reviews;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) => EShowReviewListTile(review: reviews[index]),
        childCount: reviews.length,
      ),
    );
  }
}

enum EShowReviewTextState {
  normal,
  collapsed,
  expanded,
}

class EShowReviewListTile extends StatefulWidget {
  const EShowReviewListTile({
    Key? key,
    required this.review,
  }) : super(key: key);

  final EShowReview review;

  @override
  _EShowReviewListTileState createState() => _EShowReviewListTileState();
}

class _EShowReviewListTileState extends State<EShowReviewListTile> {
  late final ValueNotifier<EShowReviewTextState> _reviewTextState;

  @override
  void initState() {
    super.initState();
    if (widget.review.content.length <= 200) {
      _reviewTextState = ValueNotifier<EShowReviewTextState>(EShowReviewTextState.normal);
    } else {
      _reviewTextState = ValueNotifier<EShowReviewTextState>(EShowReviewTextState.collapsed);
    }
  }

  @override
  void dispose() {
    _reviewTextState.dispose();
    super.dispose();
  }

  void _changeReviewTextState() {
    if (_reviewTextState.value == EShowReviewTextState.collapsed) {
      _reviewTextState.value = EShowReviewTextState.expanded;
    } else if (_reviewTextState.value == EShowReviewTextState.expanded) {
      _reviewTextState.value = EShowReviewTextState.collapsed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Chip(
            backgroundColor: AppColors.of(context).secondaryColor,
            label: SelectableText(
              widget.review.author,
              maxLines: 1,
              style: TextStyle(
                color: AppColors.of(context).whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SelectableText(
            'posted on ${_dateFormatter.format(widget.review.createdAt)}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          ValueListenableBuilder<EShowReviewTextState>(
            valueListenable: _reviewTextState,
            builder: (_, EShowReviewTextState state, Widget? child) {
              if (state == EShowReviewTextState.normal) {
                return SelectableText(widget.review.content);
              }

              final String text;
              if (state == EShowReviewTextState.collapsed) {
                text = '${widget.review.content.substring(0, 197)}...';
              } else {
                text = widget.review.content;
              }

              final Widget reviewText = SelectableText(text);

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  reviewText,
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: _changeReviewTextState,
                    child: Text(
                      state == EShowReviewTextState.collapsed ? 'Read more' : 'Show less',
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
