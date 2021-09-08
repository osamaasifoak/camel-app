import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import 'base_screen_messenger.dart';

class ScreenMessenger implements BaseScreenMessenger {
  @override
  Future<T?> showDialog<T extends Object?>({
    required BuildContext context,
    required PageBuilderFunction pageBuilder,
    double? blurFactor,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x8A000000),
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    assert(
      !barrierDismissible || barrierLabel != null,
      'If you want to set [barrierDismissible] to true, '
      '[barrierLabel] cannot be null, and vice versa.',
    );

    return showGeneralDialog(
      context: context,
      pageBuilder: pageBuilder,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      transitionBuilder: blurFactor == null
          ? null
          : (_, Animation<double> a1, __, Widget child) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurFactor * a1.value,
                  sigmaY: blurFactor * a1.value,
                ),
                child: FadeTransition(
                  opacity: a1,
                  child: child,
                ),
              );
            },
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  @override
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required BuildContext context,
    String? message,
    Widget? content,
    Duration? duration,
    Color? backgroundColor,
    double? elevation,
    bool? floating,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarAction? action,
    Animation<double>? animation,
    void Function()? onVisible,
  }) {
    assert(
      (message != null) ^ (content != null),
      'You have to choose between showing a text message or '
      'showing a content which is a widget. If you only want '
      'to show a text message, provide some `String` to the [message], '
      "and don't provide a `Widget` to the [content]. And vice versa.",
    );
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: message != null ? Text(message) : content!,
        duration: duration ?? const Duration(milliseconds: 2000),
        backgroundColor: backgroundColor ?? Theme.of(context).accentColor,
        elevation: elevation,
        behavior: floating != null && floating
            ? SnackBarBehavior.floating
            : SnackBarBehavior.fixed,
        margin: margin,
        padding: padding,
        width: width,
        shape: shape,
        action: action,
        animation: animation,
        onVisible: onVisible,
      ),
    );
  }
}
