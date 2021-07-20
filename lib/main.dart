
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';

import 'core/constants/app_apis.dart';
import 'core/constants/app_router.dart';
import 'core/services/navigation_service/base_navigation_service.dart';
import 'views/home/tabs/nowplaying/cubit/nowplaying_cubit.dart';
import 'views/home/tabs/upcoming/cubit/upcoming_cubit.dart';

import 'singletons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingCubit>(
          create: (_) => NowPlayingCubit(),
        ),
        BlocProvider<UpcomingCubit>(
          create: (_) => UpcomingCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'caMel',
        debugShowCheckedModeBanner: false,
        navigatorKey: GetIt.I<BaseNavigationService>().navigatorKey,
        scaffoldMessengerKey: GetIt.I<BaseNavigationService>().messengerKey,
        theme: ThemeData(
          primaryColor: Colors.grey[50],
          accentColor: Color(0xFF01579B), //Colors.grey[900],
          errorColor: const Color(0xffD50000),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            primary: const Color(0xff40C4FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          )),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: const Color(0xff40C4FF),
          )),
        ),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
