import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_to_text/home.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundImage: AssetImage('asset/bag.png'),
      logoWidth: 200,
      loadingText: Text(
        'By \nA₹',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      logo: Image.asset(
        'asset/1.png',
        width: 500,
      ),
      durationInSeconds: 5,
      loaderColor: Colors.white,
      backgroundColor: Colors.black,
      navigator: homePage(),
    );
  }
}
