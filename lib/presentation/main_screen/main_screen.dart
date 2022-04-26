import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';
import 'package:jaya_tirta/bloc/navigation/navigation_cubit.dart';
import 'package:jaya_tirta/presentation/home/pesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/utils/colors.dart';
import '../../bloc/authentication/authentication_bloc.dart';
import '../authentication/authentication_screen.dart';
import '../produk/produk_screen.dart';
import '../profil/profil_screen.dart';
import '../ringkasan/ringkasan_screen.dart';

class MainScreen extends StatefulWidget {
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
            MaterialPageRoute(builder: (context) => AuthenticationScreen()),
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
              icon: Icon(Icons.mail_outline),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined),
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
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
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.pesanan);
                } else if (index == 1) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.produk);
                } else if (index == 2) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.ringkasan);
                } else if (index == 3) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.profil);
                }
              },
            );
          },
        ),
        body: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
          if (state.navbarItem == NavbarItem.pesanan) {
            return PesananScreen();
          } else if (state.navbarItem == NavbarItem.produk) {
            return ProdukScreen();
          } else if (state.navbarItem == NavbarItem.ringkasan) {
            return RingkasanScreen();
          } else if (state.navbarItem == NavbarItem.profil) {
            return ProfilScreen();
          }
          return Container();
        }),
      ),
    );
  }
}
