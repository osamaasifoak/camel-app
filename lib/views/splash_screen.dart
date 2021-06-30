
import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen();

  @override 
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 2000),
      
    );
    _animationController.repeat();
    _animation = Tween(
      begin: 0.0,
      end: 6.0,
    ).animate(_animationController)
    ..addListener(() { 
      setState(() {
        
      });
    });
    Future.delayed(
      Duration(milliseconds: 2000),
      () => Navigator.of(context).pop()
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
        body: Center(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child:  ShaderMask(
              child: Text(
                'IS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Monoton',
                  fontSize: 80,
                  color: Colors.white
                ),
              ),
              shaderCallback: (rect) {
                return RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  stops: [
                    _animation.value - 4.5,
                    _animation.value - 3.5,
                    _animation.value - 2.5,
                    _animation.value - 1.25,
                    _animation.value - 0.5,
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
            ),
          ),
        ),
      ),
    );  
  }

}