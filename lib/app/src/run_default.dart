
import 'dart:convert' show jsonDecode;

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:postor/postor.dart' as postor show defaultJsonDecoder;

import '/core/constants/app_apis.dart';
import '/error_msg_handlers.dart';
import '/singletons.dart';
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

const Future<dynamic> Function(String source) _appIsolatedJsonDecoder = __appIsolatedJsonDecoder;

Future<dynamic> __appIsolatedJsonDecoder(String source) {
  return compute(
    (String source) => jsonDecode(
      source,
      reviver: (_, __) {
        // no-op
      },
    ),
    source,
  );
}
