import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_api/screens/homepage.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    });
    return const Scaffold(
      backgroundColor: Color(0xff0D1117),
      body: Center(
        child: RiveAnimation.asset("assets/github-logo.riv"),
        widthFactor: 1.5,
      ),
    );
  }
}
