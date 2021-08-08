import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';

import 'core/constants/app_apis.dart';
import 'core/constants/app_routes.dart';
import 'core/helpers/screen_router.dart';
import 'core/services/navigation_service/base_navigation_service.dart';

import 'singletons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await AppApis().loadApiKey();

  initSingletons();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'caMel',
      debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.I<BaseNavigationService>().navigatorKey,
      scaffoldMessengerKey: GetIt.I<BaseNavigationService>().messengerKey,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: const Color(0xFF01579B),
        errorColor: const Color(0xFFD50000),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Nunito Sans',
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: ScreenRouter.onGenerateRoute,
    );
  }
}
