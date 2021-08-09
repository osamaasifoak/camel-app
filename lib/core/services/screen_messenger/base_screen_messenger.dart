
import 'package:flutter/material.dart';

typedef PageBuilderFunction = Widget Function(
  BuildContext context,
  Animation<double> a1,
  Animation<double> a2,
);

abstract class BaseScreenMessenger {

  /// a shortcut for showing dialog that can have blur effect
  /// 
  /// [blurFactor] defaults to `null` which means no blur
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
  });

  /// a shortcut for showing snack bar.
  ///
  /// provide either a `String` [message] or a `Widget` [content].
  /// one of them cannot be `null`.
  ///
  /// [backgroundColor] defaults to `Theme.of(context).accentColor`
  /// 
  /// [duration] defaults to 2000 ms
  ///
  /// [floating] is used whether to show snackbar floating above all widgets
  /// including [BottomNavigationBar] and [FloatingActionButton].
  /// defaults to false: [SnackBarBehavior.fixed].
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
  });

  
}