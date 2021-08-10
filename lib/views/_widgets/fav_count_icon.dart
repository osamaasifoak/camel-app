
import 'package:flutter/material.dart';

class FavCountIcon extends StatelessWidget {
  
  const FavCountIcon({
    Key? key,
    required this.countStream,
    required this.onTap,
    this.favIconSize = 27.0,
    this.favCountTextStyle,
    this.favCountTextRadius = 8.0,
  }) : super(key: key);

  final Stream<int> countStream;
  final VoidCallback onTap;
  final double favIconSize;
  final double favCountTextRadius;
  final TextStyle? favCountTextStyle;


  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      color: Colors.grey[900],
      iconSize: favIconSize,
      padding: const EdgeInsets.all(4),
      icon: Stack(
        children: [
          const Icon(Icons.favorite_border),
          StreamBuilder<int>(
            initialData: 0,
            stream: countStream,
            builder: (_, countSnapshot) {
              return _countNumber(countSnapshot.data);
            },
          ),
        ],
      ),
    );
  }

  Widget _countNumber(int? count) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(2),
        constraints: const BoxConstraints(
          minHeight: 12,
          minWidth: 13,
        ),
        decoration: BoxDecoration(
          color: Colors.pinkAccent[400],
          borderRadius: BorderRadius.circular(favCountTextRadius),
        ),
        child: Text(
          count?.toString() ?? '0',
          textAlign: TextAlign.center,
          style: favCountTextStyle ?? const TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}