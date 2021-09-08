import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward().then(Navigator.of(context).pop);

    _animation = Tween<double>(
      begin: 0.0,
      end: 6.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: ValueListenableBuilder<double>(
            valueListenable: _animation,
            builder: (_, double animationValue, Widget? child) {
              return ShaderMask(
                shaderCallback: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 3,
                  stops: <double>[
                    animationValue - 4.5,
                    animationValue - 3.5,
                    animationValue - 2.5,
                    animationValue - 1.25,
                    animationValue - 0.15,
                  ],
                  colors: const <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF311B92),
                    Color(0xFFB388FF),
                    Color(0xFF80D8FF),
                    Color(0xFF0D47A1),
                  ],
                ).createShader,
                child: child,
              );
            },
            child: const Text(
              'camel',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Monoton',
                fontSize: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
