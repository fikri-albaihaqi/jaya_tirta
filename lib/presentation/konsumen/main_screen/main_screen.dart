import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/navigation/konsumen/konsumen_navigation_cubit.dart';
import 'package:jaya_tirta/presentation/konsumen/home/home_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/pesanan/pesanan_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/profil_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Bruce Wayne',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18.0,
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
      bottomNavigationBar:
          BlocBuilder<KonsumenNavigationCubit, KonsumenNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: true,
            elevation: 16,
            fixedColor: kJayaTirtaBlue300,
            unselectedItemColor: kJayaTirtaBlack900,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: 'Pesanan',
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
                BlocProvider.of<KonsumenNavigationCubit>(context)
                    .getKonsumenNavBarItem(KonsumenNavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<KonsumenNavigationCubit>(context)
                    .getKonsumenNavBarItem(KonsumenNavbarItem.pesanan);
              } else if (index == 2) {
                BlocProvider.of<KonsumenNavigationCubit>(context)
                    .getKonsumenNavBarItem(KonsumenNavbarItem.profil);
              }
            },
          );
        },
      ),
      body: BlocBuilder<KonsumenNavigationCubit, KonsumenNavigationState>(
          builder: (context, state) {
        if (state.navbarItem == KonsumenNavbarItem.home) {
          return HomeScreen();
        } else if (state.navbarItem == KonsumenNavbarItem.pesanan) {
          return PesananScreen();
        } else if (state.navbarItem == KonsumenNavbarItem.profil) {
          return ProfilScreen();
        }
        return Container();
      }),
    );
  }
}