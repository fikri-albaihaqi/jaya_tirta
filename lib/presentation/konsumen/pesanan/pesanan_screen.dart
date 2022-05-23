import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/utils/colors.dart';

class PesananScreen extends StatefulWidget {
  PesananScreen({Key? key, required this.user}) : super(key: key);
  User? user;

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
              child: Text(
                'Daftar Pesanan',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: kJayaTirtaBlack900,
                ),
              ),
            ),
            BlocBuilder<PesananKonsumenBloc, PesananKonsumenState>(
              builder: (context, state) {
                context.read<PesananKonsumenBloc>()
                  ..add(LoadPesananKonsumen(widget.user?.uid));
                if (state is PesananKonsumenLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PesananKonsumenLoaded) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.pesanan.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '18 Mei 2022',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      state.pesanan[index].status!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      state.pesanan[index].gambar!,
                                      scale: 2.8,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nama: ${state.pesanan[index].namaKonsumen}',
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'No Telepon: ${state.pesanan[index].noTelp}',
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Alamat: ${state.pesanan[index].alamat}',
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Jumlah: ${state.pesanan[index].jumlah}',
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Total Harga: Rp.${state.pesanan[index].total}',
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
