
class ScreenSizer {
  factory ScreenSizer() => _instance;
  ScreenSizer._internal();
  static final ScreenSizer _instance = ScreenSizer._internal();

  /// current half horizontal padding 
  double currentXPadding = 0;

  double currentHeight = 0;
  
  double _currentWidth = 0;
  double get currentWidth => _currentWidth;
  set currentWidth(double newWidth) {
    if(newWidth - currentXPadding * 2 == _currentWidth) return;

    _currentWidth = newWidth - currentXPadding * 2;
  }

  double get currentAspectRatio => _currentWidth / currentHeight;
}
