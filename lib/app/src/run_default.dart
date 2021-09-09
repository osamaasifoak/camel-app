import 'dart:convert' show jsonDecode;

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:postor/postor.dart' as postor show defaultJsonDecoder;

import '/core/constants/app_apis.dart';
import '/err_msg_handlers/err_msg_handlers.dart';
import '/singletons/singletons.dart';
import 'app_default.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await AppApis().loadApiKey();

  initSingletons();

  postor.defaultJsonDecoder = _appIsolatedJsonDecoder;

  initErrorMessageHandlers();

  runApp(const App());
}

Future<dynamic> _appIsolatedJsonDecoder(final String source) {
  return compute(jsonDecode, source);
}
