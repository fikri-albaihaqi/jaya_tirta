import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/bloc/navigation/konsumen/konsumen_navigation_cubit.dart';
import 'package:jaya_tirta/bloc/navigation/penjual/penjual_navigation_cubit.dart';
import 'package:jaya_tirta/bloc/peramalan_mingguan/peramalan_mingguan_bloc.dart';
import 'package:jaya_tirta/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/data/repositories/konsumen/konsumen_repository.dart';
import 'package:jaya_tirta/data/repositories/penjual/penjual_repository.dart';
import 'package:jaya_tirta/data/repositories/peramalan/peramalan_repository.dart';
import 'package:jaya_tirta/data/repositories/pesanan/pesanan_repository.dart';
import 'package:jaya_tirta/data/repositories/produk/produk_repository.dart';
import 'package:jaya_tirta/presentation/konsumen/main_screen/konsumen_main_screen.dart';
import 'package:jaya_tirta/presentation/welcome/welcome.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
        BlocProvider(
          create: (_) => PeramalanBulananBloc(
            peramalanRepository: PeramalanRepository(),
          )..add(LoadPeramalanBulanan()),
        ),
        BlocProvider(
          create: (_) => PeramalanMingguanBloc(
            peramalanRepository: PeramalanRepository(),
          )..add(LoadPeramalanMingguan()),
        ),
        BlocProvider(
          create: (_) => FilterBloc(
            pesananBloc: _.read<PesananBloc>(),
          )..add(LoadFilter()),
        ),
        BlocProvider(
          create: (_) => FilterPesananKonsumenBloc(
            pesananKonsumenBloc: _.read<PesananKonsumenBloc>(),
          )..add(LoadFilterPesananKonsumen()),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            pesananBloc: _.read<PesananBloc>(),
          )..add(LoadSearch()),
        ),
        BlocProvider(
          create: (_) => SearchPesananKonsumenBloc(
            pesananKonsumenBloc: _.read<PesananKonsumenBloc>(),
          )..add(LoadPesananKonsumenSearch()),
        ),
        BlocProvider(
          create: (_) => PenjualBloc(
            penjualRepository: PenjualRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CrudPenjualBloc(
            penjualRepository: PenjualRepository(),
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
          builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: kJayaTirtaBlue500)),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                print('isEmpty: ${snapshot.data?.email}');
                if (snapshot.data != null) {
                  if (snapshot.data?.email != '') {
                    return const MainScreen();
                  } else if (snapshot.data?.email == '') {
                    return const KonsumenMainScreen();
                  }
                }
                return const WelcomeScreen();
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
          builder: (context) => const WelcomeScreen(),
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
