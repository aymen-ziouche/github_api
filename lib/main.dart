import 'package:flutter/material.dart';
import 'package:github_api/screens/homepage.dart';
import 'package:github_api/screens/repospage.dart';
import 'package:github_api/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialRoute: SplashScreen.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        ReposPage.id: (context) => const ReposPage(),
        SplashScreen.id: (context) => const SplashScreen(),
      },
    );
  }
}
