
class ScreenSizer {
  static final ScreenSizer _instance = ScreenSizer._internal();
  factory ScreenSizer() => _instance;
  ScreenSizer._internal();

  /// current half horizontal padding 
  double currentXPadding = 0;
}