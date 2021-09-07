import 'dart:convert' show jsonDecode;
import 'dart:math' as math show max;

import 'package:config/config.dart' as config;
import 'package:flutter/foundation.dart' as foundation show compute, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:postor/postor.dart' as postor show defaultJsonDecoder;

import 'core/constants/app_apis.dart';
import 'core/constants/app_routes.dart';
import 'core/helpers/screen_router.dart';
import 'core/helpers/screen_sizer.dart';
import 'error_msg_handlers.dart';
import 'singletons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  config.configureApp();

  await AppApis().loadApiKey();

  initSingletons();

  postor.defaultJsonDecoder = appDefaultJsonDecoder;

  initErrorMessageHandlers();

  runApp(const App());
}

Future<dynamic> appDefaultJsonDecoder(String source) {
  return foundation.compute(jsonDecode, source);
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData botNavBarTheme = Theme.of(context).bottomNavigationBarTheme;

    final Widget app = MaterialApp(
      title: 'caMel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: const Color(0xFF01579B),
        errorColor: const Color(0xFFD50000),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Nunito Sans',
        bottomNavigationBarTheme: botNavBarTheme.copyWith(elevation: 0),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (RouteSettings settings) => ScreenRouter<dynamic>(settings: settings),
    );

    if (foundation.kIsWeb) {
      return Listener(
        onPointerDown: ScreenRouter.onPointerDownEvent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            ScreenSizer().currentXPadding = math.max(0.0, constraints.maxWidth - 1280) / 2;
            ScreenSizer().currentWidth = constraints.maxWidth;
            ScreenSizer().currentHeight = constraints.maxHeight;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSizer().currentXPadding),
              child: PhysicalModel(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                elevation: 10,
                child: app,
              ),
            );
          },
        ),
      );
    }
    
    final Size screenSize = MediaQuery.of(context).size;
    ScreenSizer().currentWidth = screenSize.width;
    ScreenSizer().currentHeight = screenSize.height;

    return Listener(
      onPointerDown: ScreenRouter.onPointerDownEvent,
      child: app,
    );
  }
}
