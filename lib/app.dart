import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'colors.dart';

class JayaTirtaApp extends StatelessWidget {
  const JayaTirtaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const LoginPage(),
      fullscreenDialog: true,
    );
  }
}

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kJayaTirtaBlue100,
      onPrimary: kJayaTirtaBlack900,
      secondary: kJayaTirtaBlack900,
      error: kJayaTirtaErrorRed,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kJayaTirtaBlue100,
    ),
    // inputDecorationTheme: const InputDecorationTheme(
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       width: 2.0,
    //       color: kShrineBrown900,
    //     ),
    //   ),
    //   border: CutCornersBorder(),
    // ),
  );
}
