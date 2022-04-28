import 'package:flutter/material.dart';
import 'package:jaya_tirta/presentation/konsumen/home/home_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/main_screen/main_screen.dart';
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
      body: Container(
        color: kJayaTirtaBlue500,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(24.0),
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
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
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
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthenticationScreen(),
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
      ),
    );
  }
}
