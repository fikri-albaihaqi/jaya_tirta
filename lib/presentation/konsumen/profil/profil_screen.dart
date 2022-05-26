import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/data_diri_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/edit_data_diri.dart';
import 'package:jaya_tirta/utils/colors.dart';

import '../../../bloc/blocs.dart';

class ProfilScreen extends StatefulWidget {
  ProfilScreen({Key? key, required this.user}) : super(key: key);
  User? user;

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<KonsumenBloc, KonsumenState>(
                  builder: (context, state) {
                    context
                        .read<KonsumenBloc>()
                        .add(LoadKonsumen(id: widget.user!.uid));
                    if (state is KonsumenLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is KonsumenLoaded) {
                      return Row(
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.konsumen[0].nama}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${state.konsumen[0].alamat}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                    Text(
                                      '${state.konsumen[0].noTelp}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditDataDiriScreen(
                                              user: widget.user,
                                              konsumen: state.konsumen,
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
                      );
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.help_outline_outlined),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Cara Pemesanan'),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.support),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Bantuan'),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
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
      ),
    );
  }
}
