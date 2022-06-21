import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/penjual/profil/edit_data_penjual.dart';
import 'package:jaya_tirta/utils/colors.dart';

class ProfilPenjualScreen extends StatefulWidget {
  ProfilPenjualScreen({Key? key, required this.user}) : super(key: key);
  User? user;

  @override
  State<ProfilPenjualScreen> createState() => _ProfilPenjualScreenState();
}

class _ProfilPenjualScreenState extends State<ProfilPenjualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      body: BlocBuilder<PenjualBloc, PenjualState>(
        builder: (context, state) {
          context.read<PenjualBloc>().add(LoadPenjual(id: widget.user!.uid));
          if (state is PenjualLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PenjualLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            size: 80,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Builder(builder: (context) {
                                  if (state.penjual.isEmpty) {
                                    return const Text(
                                      'Selamat Datang!',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.penjual[0].nama}',
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${state.penjual[0].noTelp}',
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditDataPenjualScreen(
                                              user: widget.user,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit_outlined),
                                    ),
                                    const Text('Edit'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthenticationBloc>().add(LogOutRequested());
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.power_settings_new_outlined),
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Log Out'),
                              ],
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
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
    );
  }
}
