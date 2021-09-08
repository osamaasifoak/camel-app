import 'package:flutter/material.dart';
import '/core/models/entertainment_show/entertainment_show_reviews.dart';

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
  late final ValueNotifier<EShowReviewTextState>
      _reviewTextState; // = (EShowReviewTextState.collapsed);

  @override
  void initState() {
    super.initState();
    if (widget.review.content.length <= 200) {
      _reviewTextState =
          ValueNotifier<EShowReviewTextState>(EShowReviewTextState.normal);
    } else {
      _reviewTextState =
          ValueNotifier<EShowReviewTextState>(EShowReviewTextState.collapsed);
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
    return ListTile(
      title: Text(
        widget.review.author,
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: ValueListenableBuilder<EShowReviewTextState>(
        valueListenable: _reviewTextState,
        builder: (_, EShowReviewTextState state, Widget? child) {
          if (state == EShowReviewTextState.normal) {
            return child!;
          }

          final Widget reviewText = state == EShowReviewTextState.collapsed
              ? Text(
                  '${widget.review.content.substring(0, 197)}...',
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                )
              : child!;

          return Wrap(
            direction: Axis.vertical,
            children: <Widget>[
              reviewText,
              GestureDetector(
                onTap: _changeReviewTextState,
                child: Text(
                  state == EShowReviewTextState.collapsed
                      ? 'Read more'
                      : 'Show less',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          );
        },
        child: Text(
          widget.review.content,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
