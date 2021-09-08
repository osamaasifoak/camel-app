import 'dart:math' show max, sqrt;

import 'package:flutter/material.dart';

/// Copyright 2021 Alexander Zhdanov
/// https://github.com/qwert2603
///
/// Licensed under the Apache License, Version 2.0 (the "License");
@immutable
class CircularRevealClipper extends CustomClipper<Path> {
  const CircularRevealClipper({
    required this.fraction,
    this.centerAlignment,
    this.centerOffset,
    this.minRadius,
    this.maxRadius,
  });

  final double fraction;
  final Alignment? centerAlignment;
  final Offset? centerOffset;
  final double? minRadius;
  final double? maxRadius;

  @override
  Path getClip(Size size) {
    final Offset center = centerAlignment?.alongSize(size) ??
        centerOffset ??
        Offset(size.width / 2, size.height / 2);
    final double minRadius = this.minRadius ?? 0;
    final double maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(minRadius, maxRadius, fraction),
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  static double calcMaxRadius(Size size, Offset center) {
    final double w = max(center.dx, size.width - center.dx);
    final double h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }

  static double lerpDouble(double a, double b, double t) {
    return a * (1.0 - t) + b * t;
  }
}
