import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';

@Deprecated('Use [NoShimmer] instead')
class DefaultShimmer extends StatelessWidget {
  @Deprecated('Use [NoShimmer] instead')
  const DefaultShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1000),
      baseColor: const Color(0xFFEEEEEE), // Colors.grey[200]
      highlightColor: const Color(0xFFF5F5F5), // Colors.grey[100]
      child: child,
    );
  }
}

class NoShimmer extends StatelessWidget {
  /// creates a [PlainRect] painted with [Colors.grey] of `200`
  ///
  /// if [width] is not specified, then it defaults to [BoxConstraints.maxWidth]
  ///
  /// if [height] is no specified, then it defaults to [BoxConstraints.maxHeight]
  ///
  /// color defaults to `Color(0xFFEEEEEE)` and cannot be null
  const NoShimmer({
    Key? key,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.color = const Color(0xFFEEEEEE),
  })  : assert(width == null || width >= 0.0 && width != double.infinity),
        assert(height == null || height >= 0.0 && height != double.infinity),
        super(key: key);

  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  /// defaults to [Colors.grey] of `200`
  final Color color;

  @override
  Widget build(BuildContext context) {
    Widget result = PlainRect(
      color: color,
      height: height,
      width: width,
    );
    if (borderRadius != null) {
      result = ClipRRect(
        borderRadius: borderRadius,
        child: result,
      );
    }
    if (padding != null) {
      result = Padding(
        padding: padding!,
        child: result,
      );
    }
    return result;
  }
}

class PlainRect extends LeafRenderObjectWidget {
  /// a widget that is filled with [color] forming a rectangular object
  /// with the size of [width] x [height]
  const PlainRect({
    Key? key,
    this.height,
    this.width,
    required this.color,
  })  : assert(width == null || width >= 0.0 && width != double.infinity),
        assert(height == null || height >= 0.0 && height != double.infinity),
        super(key: key);

  final double? width;
  final double? height;

  /// should defaults to [Colors.grey] of `200`
  final Color color;

  @override
  RenderPlainRect createRenderObject(BuildContext context) {
    return RenderPlainRect(
      color: color,
      height: height,
      width: width,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderPlainRect renderObject) {
    renderObject
      ..color = color
      ..height = height
      ..width = width;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('width', width));
  }
}

class RenderPlainRect extends RenderBox {
  RenderPlainRect({
    required Color color,
    required double? height,
    required double? width,
  })  : _color = color,
        _height = height,
        _width = width;

  Color _color;
  Color get color => _color;
  set color(Color newColor) {
    if (newColor == _color) return;

    _color = newColor;
    markNeedsPaint();
  }

  double? _height;
  double? get height => _height;
  set height(double? newHeight) {
    if (newHeight == _height) return;

    _height = newHeight;
    markNeedsLayout();
  }

  double? _width;
  double? get width => _width;
  set width(double? newWidth) {
    if (newWidth == _width) return;

    _width = newWidth;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = width ?? constraints.maxWidth;
    final desiredHeight = height ?? constraints.maxWidth;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    canvas.save();

    final Paint paintRect = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRect(offset & size, paintRect);

    canvas.restore();
  }
}
