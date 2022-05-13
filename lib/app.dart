import 'package:flutter/material.dart';
import 'package:jaya_tirta/presentation/welcome/welcome.dart';

class JayaTirtaApp extends StatelessWidget {
  const JayaTirtaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      initialRoute: '/welcome',
      onGenerateRoute: _getRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name != '/welcome') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const WelcomeScreen(),
      fullscreenDialog: true,
    );
  }
}
