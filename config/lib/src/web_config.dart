import 'package:flutter_web_plugins/flutter_web_plugins.dart' show PathUrlStrategy, setUrlStrategy;

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}