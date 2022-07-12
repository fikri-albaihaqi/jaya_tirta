import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/konsumen/pesanan/detail_pesanan_konsumen.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/widgets/search_pesanan_konsumen_box.dart';

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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: const [
                  Text(
                    'Daftar Pesanan',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: kJayaTirtaBlack900,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SearchPesananKonsumenBox(),
                ],
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPesananKonsumenScreen(
                                  pesanan: state.pesanan[index]),
                            ),
                          );
                        },
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
                                      state.pesanan[index].tanggalPembelian!,
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
                                    Image.network(
                                      state.pesanan[index].gambar!,
                                      scale: 5,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.pesanan[index].namaProduk}',
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${state.pesanan[index].jumlah} galon',
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Harga: Rp.${state.pesanan[index].total}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      child: Text(
                                        'Lihat Detail',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
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
