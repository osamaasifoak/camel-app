
import 'package:config/config.dart' as config;
import 'package:flutter/material.dart' deferred as _material show WidgetsFlutterBinding, runApp;

import '/core/constants/app_apis.dart' show AppApis;
import '/error_msg_handlers.dart';
import '/singletons.dart';
import 'app_web.dart' deferred as _app;

Future<void> run() async {
  await _material.loadLibrary();
  
  _material.WidgetsFlutterBinding.ensureInitialized();

  config.configureApp();

  await AppApis().loadApiKey();

  initSingletons();

  initErrorMessageHandlers();

  await _app.loadLibrary();

  _material.runApp(_app.App());
}
