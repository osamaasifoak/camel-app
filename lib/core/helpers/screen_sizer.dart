import 'package:flutter/foundation.dart';

class ScreenSizer extends ChangeNotifier {
  factory ScreenSizer() => _instance;
  ScreenSizer._internal();
  static final ScreenSizer _instance = ScreenSizer._internal();

  /// current half horizontal padding
  double _currentXPadding = 0;
  double get currentXPadding => _currentXPadding;
  set currentXPadding(final double newXPadding) {
    if (newXPadding == _currentXPadding) {
      return;
    }

    _currentXPadding = newXPadding;
    notifyListeners();
  }

  double _currentHeight = 0;
  double get currentHeight => _currentHeight;
  set currentHeight(final double newHeight) {
    if (newHeight == _currentHeight) {
      return;
    }

    _currentHeight = newHeight;
    notifyListeners();
  }

  double _currentWidth = 0;
  double get currentWidth => _currentWidth;
  set currentWidth(final double newWidth) {
    final double _newWidth = newWidth - _currentXPadding * 2;
    if (_newWidth == _currentWidth) return;

    _currentWidth = _newWidth;
    notifyListeners();
  }

  double get currentAspectRatio => _currentWidth / _currentHeight;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenSizer &&
        other._currentXPadding == _currentXPadding &&
        other._currentHeight == _currentHeight &&
        other._currentWidth == _currentWidth;
  }

  @override
  int get hashCode => _currentXPadding.hashCode ^ _currentHeight.hashCode ^ _currentWidth.hashCode;
}
