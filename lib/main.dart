import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/bloc/navigation/konsumen/konsumen_navigation_cubit.dart';
import 'package:jaya_tirta/bloc/navigation/penjual/penjual_navigation_cubit.dart';
import 'package:jaya_tirta/bloc/pesanan_konsumen/pesanan_konsumen_bloc.dart';
import 'package:jaya_tirta/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/data/repositories/konsumen/konsumen_repository.dart';
import 'package:jaya_tirta/data/repositories/pesanan/pesanan_repository.dart';
import 'package:jaya_tirta/data/repositories/produk/produk_repository.dart';
import 'package:jaya_tirta/presentation/konsumen/main_screen/konsumen_main_screen.dart';
import 'app.dart';
import 'presentation/penjual/main_screen/main_screen.dart';
import 'utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PenjualNavigationCubit(),
        ),
        BlocProvider(
          create: (_) => KonsumenNavigationCubit(),
        ),
        BlocProvider(
          create: (_) => AuthenticationBloc(
            authRepository: RepositoryProvider.of<AuthenticationRepository>(_),
          ),
        ),
        BlocProvider(
          create: (_) => ProdukBloc(
            produkRepository: ProdukRepository(),
          )..add(LoadProduk()),
        ),
        BlocProvider(
          create: (_) => PesananBloc(
            pesananRepository: PesananRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => PesananKonsumenBloc(
            pesananRepository: PesananRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CrudProdukBloc(
            produkRepository: ProdukRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CrudKonsumenBloc(
            konsumenRepository: KonsumenRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CrudPesananBloc(
            pesananRepository: PesananRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => KonsumenBloc(
            konsumenRepository: KonsumenRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => SharedPreferencesBloc(
            konsumenRepository: KonsumenRepository(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return AuthenticationRepository();
      },
      child: BlocProvider(
        create: (context) {
          return AuthenticationBloc(
            authRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
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
                if (snapshot.data?.email != null) {
                  return const MainScreen();
                } else if (snapshot.data?.email == null) {
                  return const KonsumenMainScreen();
                }
                return const SplashScreen();
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
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const JayaTirtaApp(),
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
