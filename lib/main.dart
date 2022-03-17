import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jaya Tirta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: JayaTirtaApp(),
        title: new Text(
          'Jaya Tirta',
          style: new TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
    );
  }
}
