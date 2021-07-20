
import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen();

  @override 
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _animation = Tween<double>(
      begin: 0.0,
      end: 6.0,
    ).animate(_animationController);

    Future.delayed(
      const Duration(milliseconds: 2000),
      Navigator.of(context).pop,
    );
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
            child: Text(
              'IS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Monoton',
                fontSize: 80,
                color: Colors.white
              ),
            ),
            builder: (_, animationValue, child) {
              return ShaderMask(
              child: child,
              shaderCallback: (rect) {
                return RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  stops: [
                    animationValue - 4.5,
                    animationValue - 3.5,
                    animationValue - 2.5,
                    animationValue - 1.25,
                    animationValue - 0.5,
                  ],
                  colors: [
                    Colors.blue[900]!,
                    
                    Colors.deepPurple[900]!,
                    Colors.deepPurpleAccent[100]!,
                    
                    Colors.lightBlueAccent,
                    Colors.blue[900]!,
                    
                  ],
                ).createShader(rect);
              },
            );
            },
          ),
        ),
      ),
    );  
  }

}