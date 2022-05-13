import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';
import 'package:jaya_tirta/bloc/navigation/penjual/penjual_navigation_cubit.dart';
import 'package:jaya_tirta/presentation/penjual/pesanan/pesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/presentation/welcome/welcome.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import '../produk/produk_screen.dart';
import '../profil/profil_screen.dart';
import '../ringkasan/ringkasan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          // Navigate to the sign in screen when the user Signs Out
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kJayaTirtaBlue500,
          elevation: 0,
          leading: const Icon(
            Icons.account_circle_outlined,
            size: 32.0,
          ),
          centerTitle: false,
          titleSpacing: 0.0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.email}',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Text(
                'Owner Jaya Tirta',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mail_outline),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
            ),
          ],
        ),
        bottomNavigationBar:
            BlocBuilder<PenjualNavigationCubit, PenjualNavigationState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.index,
              showUnselectedLabels: true,
              elevation: 16,
              fixedColor: kJayaTirtaBlue300,
              unselectedItemColor: kJayaTirtaBlack900,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  label: 'Pesanan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  label: 'Produk',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article_outlined),
                  label: 'Ringkasan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Profile',
                ),
              ],
              onTap: (index) {
                if (index == 0) {
                  BlocProvider.of<PenjualNavigationCubit>(context)
                      .getPenjualNavBarItem(PenjualNavbarItem.pesanan);
                } else if (index == 1) {
                  BlocProvider.of<PenjualNavigationCubit>(context)
                      .getPenjualNavBarItem(PenjualNavbarItem.produk);
                } else if (index == 2) {
                  BlocProvider.of<PenjualNavigationCubit>(context)
                      .getPenjualNavBarItem(PenjualNavbarItem.ringkasan);
                } else if (index == 3) {
                  BlocProvider.of<PenjualNavigationCubit>(context)
                      .getPenjualNavBarItem(PenjualNavbarItem.profil);
                }
              },
            );
          },
        ),
        body: BlocBuilder<PenjualNavigationCubit, PenjualNavigationState>(
            builder: (context, state) {
          if (state.navbarItem == PenjualNavbarItem.pesanan) {
            return const PesananScreen();
          } else if (state.navbarItem == PenjualNavbarItem.produk) {
            return const ProdukScreen();
          } else if (state.navbarItem == PenjualNavbarItem.ringkasan) {
            return const RingkasanScreen();
          } else if (state.navbarItem == PenjualNavbarItem.profil) {
            return const ProfilScreen();
          }
          return Container();
        }),
      ),
    );
  }
}
