import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors extends InheritedWidget {
  const AppColors({
    Key? key,
    required Widget child,
    this.primaryColor = defaultPrimaryColor,
    this.secondaryColor = defaultSecondaryColor,
    this.alphaSecondaryColor = defaultAlphaSecondaryColor,
    this.blackColor = defaultBlackColor,
    this.whiteColor = defaultWhiteColor,
    this.amberColor = defaultAmberColor,
    this.yellowColor = defaultYellowColor,
    this.errorColor = defaultErrorColor,
  }) : super(key: key, child: child);

  static const Color defaultPrimaryColor = Color(0xFFFFFFFF); // Colors.white
  static const Color defaultSecondaryColor = Color(0xFF01579B);
  static const Color defaultAlphaSecondaryColor = Color(0xFFE3F2FD); // Colors.blue[50]
  static const Color defaultBlackColor = Color(0xFF212121); // Colors.grey[900]
  static const Color defaultWhiteColor = Color(0xFFFAFAFA); // Colors.grey[50]
  static const Color defaultAmberColor = Color(0xFFFFCA28); // Colors.amber[400]
  static const Color defaultYellowColor = Color(0xFFF9A825); // Colors.yellow[800]
  static const Color defaultErrorColor = Color(0xFFD50000);

  /// defaults to `Color(0xFFFFFFFF)` a.k.a. `Colors.white`
  final Color primaryColor;

  /// defaults to `Color(0xFF01579B)`
  final Color secondaryColor;

  /// defaults to `Color(0xFFE3F2FD)` a.k.a. `Colors.blue[50]`
  final Color alphaSecondaryColor;

  /// defaults to `Color(0xFF212121)` a.k.a. `Colors.grey[900]`
  final Color blackColor;

  /// defaults to `Color(0xFFFAFAFA)` a.k.a. `Colors.grey[50]`
  final Color whiteColor;

  /// defaults to `Color(0xFFFCA28)` a.k.a. `Colors.amber[400]`
  final Color amberColor;

  /// defaults to `Color(0xFFF9A825)` a.k.a. `Colors.yellow[800]`
  final Color yellowColor;

  /// defaults to `Color(0xFFD50000)`
  final Color errorColor;

  static AppColors of(BuildContext context) {
    final AppColors? appColors = context.dependOnInheritedWidgetOfExactType<AppColors>();
    assert(appColors != null);
    return appColors!;
  }

  @override
  bool updateShouldNotify(covariant AppColors oldWidget) {
    return oldWidget.primaryColor != primaryColor &&
        oldWidget.secondaryColor != secondaryColor &&
        oldWidget.alphaSecondaryColor != alphaSecondaryColor &&
        oldWidget.blackColor != blackColor &&
        oldWidget.whiteColor != whiteColor &&
        oldWidget.yellowColor != yellowColor &&
        oldWidget.errorColor != errorColor;
  }
}
