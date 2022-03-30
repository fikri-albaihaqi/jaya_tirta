import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jaya_tirta/bloc/authentication_bloc.dart';
import 'package:jaya_tirta/data/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/presentation/home/home.dart';
import 'app.dart';
import 'utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        child: MaterialApp(
          title: 'Jaya Tirta',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return const HomePage();
                }
                return SplashScreen();
              }),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => JayaTirtaApp(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kJayaTirtaBlue500,
        image: DecorationImage(
          image: AssetImage('graphics/SplashScreen.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
