
import 'dart:math' as math show max;

import 'package:flutter/material.dart';
import '/core/constants/app_colors.dart';
import '/core/constants/app_routes.dart';
import '/core/helpers/screen_router.dart';
import '/core/helpers/screen_sizer.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData botNavBarTheme = Theme.of(context).bottomNavigationBarTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final IconThemeData iconTheme = Theme.of(context).iconTheme;
    final InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final TextSelectionThemeData textSelectionTheme = Theme.of(context).textSelectionTheme;
    final ToggleButtonsThemeData toggleButtonsTheme = Theme.of(context).toggleButtonsTheme;

    final Widget app = AppColors(
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            title: 'caMel',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              bottomNavigationBarTheme: botNavBarTheme.copyWith(elevation: 0),
              brightness: Brightness.light,
              colorScheme: colorScheme.copyWith(
                primary: AppColors.of(context).primaryColor,
                onPrimary: AppColors.of(context).blackColor,
                secondary: AppColors.of(context).secondaryColor,
              ),
              errorColor: AppColors.of(context).errorColor,
              fontFamily: 'Nunito Sans',
              textSelectionTheme: textSelectionTheme.copyWith(
                cursorColor: AppColors.of(context).secondaryColor,
                selectionColor: AppColors.of(context).alphaSecondaryColor,
              ),
              iconTheme: iconTheme.copyWith(
                color: AppColors.of(context).secondaryColor,
              ),
              inputDecorationTheme: inputDecorationTheme.copyWith(
                focusColor: AppColors.of(context).secondaryColor,
              ),
              toggleButtonsTheme: toggleButtonsTheme.copyWith(
                fillColor: AppColors.of(context).alphaSecondaryColor,
                selectedColor: AppColors.of(context).secondaryColor,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: AppRoutes.home,
            onGenerateRoute: (RouteSettings settings) => ScreenRouter<dynamic>(settings: settings),
          );
        },
      ),
    );

    return Listener(
      onPointerDown: ScreenRouter.onPointerDownEvent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          ScreenSizer().currentXPadding = math.max(0.0, constraints.maxWidth - 1280) / 2;
          ScreenSizer().currentWidth = constraints.maxWidth;
          ScreenSizer().currentHeight = constraints.maxHeight;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSizer().currentXPadding,
            ),
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
}
