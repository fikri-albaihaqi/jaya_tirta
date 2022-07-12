import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/navigation/konsumen/konsumen_navigation_cubit.dart';
import 'package:jaya_tirta/presentation/konsumen/chat/konsumen_obrolan_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/home/home_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/pesanan/pesanan_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/profil_screen.dart';
import 'package:jaya_tirta/presentation/welcome/welcome.dart';
import 'package:jaya_tirta/utils/colors.dart';

import '../../../bloc/blocs.dart';

class KonsumenMainScreen extends StatefulWidget {
  const KonsumenMainScreen({Key? key}) : super(key: key);

  @override
  _KonsumenMainScreenState createState() => _KonsumenMainScreenState();
}

class _KonsumenMainScreenState extends State<KonsumenMainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
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
          title: BlocBuilder<KonsumenBloc, KonsumenState>(
            builder: (context, state) {
              context.read<KonsumenBloc>().add(LoadKonsumen(id: user?.uid));
              if (state is KonsumenLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is KonsumenLoaded) {
                if (state.konsumen.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Selamat datang!',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.konsumen.first.nama}',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }
              } else {
                return const Text('Something went worng');
              }
            },
          ),
          actions: [
            BlocBuilder<KonsumenBloc, KonsumenState>(
              builder: (context, state) {
                context.read<KonsumenBloc>().add(LoadKonsumen(id: user?.uid));
                if (state is KonsumenLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is KonsumenLoaded) {
                  if (state.konsumen.isEmpty) {
                    return IconButton(
                      style: IconButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        null;
                      },
                      icon: const Icon(
                        Icons.mail_outline,
                        color: Colors.grey,
                      ),
                    );
                  } else {
                    return BlocBuilder<PenjualBloc, PenjualState>(
                      builder: (context, status) {
                        context.read<PenjualBloc>().add(LoadAllPenjual());
                        if (status is PenjualLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (status is PenjualLoaded) {
                          return IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KonsumenObrolanScreen(
                                    penjual: status.penjual.first,
                                    konsumen: state.konsumen.first,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.mail_outline),
                          );
                        } else {
                          return const Text('Something went wrong');
                        }
                      },
                    );
                  }
                } else {
                  return const Text('Something went worng');
                }
              },
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
            return HomeScreen(
              user: user,
            );
          } else if (state.navbarItem == KonsumenNavbarItem.pesanan) {
            return PesananScreen(
              user: user,
            );
          } else if (state.navbarItem == KonsumenNavbarItem.profil) {
            return ProfilScreen(
              user: user,
            );
          }
          return Container();
        }),
      ),
    );
  }
}
