import 'package:flutter/material.dart';
import 'package:jaya_tirta/presentation/penjual/authentication/authentication_screen.dart';
import 'package:jaya_tirta/presentation/welcome/welcome.dart';
import 'utils/colors.dart';

class JayaTirtaApp extends StatelessWidget {
  const JayaTirtaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationScreen(),
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
