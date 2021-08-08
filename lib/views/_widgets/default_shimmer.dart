
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultShimmer extends StatelessWidget{

  const DefaultShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0), // Colors.grey[300] 
      highlightColor: const Color(0xFFF5F5F5), // Colors.grey[100]
      child: child,
    );
  }

}