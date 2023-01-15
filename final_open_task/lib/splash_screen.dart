import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:uniproject/pages/Login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SplashScreenView(
        // navigateRoute: Home(),
        duration: 1000,
        imageSize: 200,
        backgroundColor: Colors.white,
        imageSrc: 'assets/logo.jpg',
        text: "Table Generater",
        textType: TextType.ColorizeAnimationText,
        colors: [
          Colors.blue,
        ],
        textStyle: TextStyle(
          fontSize: 24.0,
        ),
        navigateRoute: Login(),
      ),
    );
  }
}
