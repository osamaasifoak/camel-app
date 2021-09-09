import 'package:config/config.dart' as config;

import 'package:flutter/material.dart' deferred as _material show WidgetsFlutterBinding, runApp;
import 'package:flutter/material.dart' deferred as _material_lazy
    show
        BoxConstraints,
        Builder,
        BuildContext,
        LayoutBuilder,
        Listener,
        MaterialApp,
        PhysicalModel,
        Scaffold,
        StatelessWidget,
        Widget;

import '/core/constants/app_apis.dart' show AppApis;
import '/err_msg_handlers/err_msg_handlers.dart';
import '/singletons/singletons.dart';
import 'app_web.dart' deferred as _app;

Future<void> run() async {
  await _material.loadLibrary();

  _material.WidgetsFlutterBinding.ensureInitialized();

  config.configureApp();

  await AppApis().loadApiKey();

  await initSingletons();

  await initErrorMessageHandlers();

  await _material_lazy.loadLibrary();
  _();
  await _app.loadLibrary();

  _material.runApp(_app.App());
}

@pragma('vm:entry-point')
void _() {
  // ignore: avoid_print
  print(<Type>[
    _material_lazy.BoxConstraints,
    _material_lazy.BuildContext,
    _material_lazy.Builder,
    _material_lazy.LayoutBuilder,
    _material_lazy.Listener,
    _material_lazy.MaterialApp,
    _material_lazy.PhysicalModel,
    _material_lazy.Scaffold,
    _material_lazy.StatelessWidget,
    _material_lazy.Widget,
  ]);
}
