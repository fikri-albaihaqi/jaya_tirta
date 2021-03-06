import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';
import 'package:jaya_tirta/bloc/navigation/penjual/penjual_navigation_cubit.dart';
import 'package:jaya_tirta/data/repositories/peramalan/peramalan_repository.dart';
import 'package:jaya_tirta/presentation/penjual/chat/daftar_chat_screen.dart';
import 'package:jaya_tirta/presentation/penjual/pesanan/pesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/presentation/welcome/welcome.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import '../produk/produk_screen.dart';
import '../profil/profil_penjual_screen.dart';
import '../ringkasan/ringkasan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String bulan = DateFormat('y-MM').format(now);
    PeramalanRepository peramalanRepository = PeramalanRepository();
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
          title: BlocBuilder<PenjualBloc, PenjualState>(
            builder: (context, state) {
              context.read<PenjualBloc>().add(LoadPenjual(id: user.uid));
              if (state is PenjualLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PenjualLoaded) {
                if (state.penjual.isEmpty) {
                  return const Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                } else {
                  return BlocBuilder<PenjualanBulananBloc,
                      PenjualanBulananState>(
                    builder: (context, status) {
                      if (status is PenjualanBulananLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (status is PenjualanBulananLoaded) {
                        if (bulan != status.penjualanBulanan) {
                          peramalanRepository.runRamalan();
                        }
                        return Text(
                          '${state.penjual[0].nama}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      } else {
                        return const Text('Something went wrong');
                      }
                    },
                  );
                }
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
          actions: [
            BlocBuilder<PenjualBloc, PenjualState>(
              builder: (context, state) {
                if (state is PenjualLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PenjualLoaded) {
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DaftarChatScreen(
                            penjual: state.penjual[0],
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
            return ProfilPenjualScreen(user: user);
          }
          return Container();
        }),
      ),
    );
  }
}
