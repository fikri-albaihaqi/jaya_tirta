import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/konsumen/main_screen/konsumen_main_screen.dart';
import 'package:jaya_tirta/presentation/penjual/authentication/authentication_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const KonsumenMainScreen()));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return Container(
                color: kJayaTirtaBlue500,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Image.asset('graphics/welcome.png'),
                          const Text(
                            'Selamat Datang Di Jaya Tirta!',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Untuk melakukan pemesanan tekan tombol "Mulai Memesan Sekarang!"',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthenticationBloc>().add(
                                      KonsumenLogInRequested(),
                                    );
                              },
                              child: const Text(
                                'Mulai Memesan Sekarang!',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Nunito',
                                  color: kJayaTirtaBlack900,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AuthenticationScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login Sebagai Penjual',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
