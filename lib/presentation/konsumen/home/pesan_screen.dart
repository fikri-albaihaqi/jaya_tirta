import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/konsumen/home/konfirmasi_pesanan_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class PesanScreen extends StatefulWidget {
  PesanScreen({Key? key, required this.produk, required this.user})
      : super(key: key);
  Produk produk;
  User? user;

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  int jumlah = 1;
  int total = 0;

  void _tambahJumlah() {
    setState(() {
      jumlah++;
    });
  }

  void _kurangiJumlah() {
    setState(() {
      jumlah--;
    });
  }

  int hitungTotal(Produk produk) {
    return total = produk.harga! * jumlah;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue500,
      appBar: AppBar(
        title: const Text('Pesan Produk'),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.network(
                  widget.produk.gambar!,
                  scale: 2.5,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  widget.produk.namaProduk!,
                  style: const TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 36.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'Stok: ${widget.produk.stok!} pcs',
                  style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Stok: Rp ${widget.produk.harga!}',
                  style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(height: 32.0),
                const Text(
                  'Jumlah Pembelian',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    jumlah <= 1
                        ? IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              null;
                            },
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.grey,
                            iconSize: 32.0,
                          )
                        : IconButton(
                            onPressed: () {
                              _kurangiJumlah();
                            },
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.white,
                            iconSize: 32.0,
                          ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      '$jumlah',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    jumlah >= 20
                        ? IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              null;
                            },
                            icon: const Icon(Icons.add_circle),
                            color: Colors.grey,
                            iconSize: 32.0,
                          )
                        : IconButton(
                            onPressed: () {
                              _tambahJumlah();
                            },
                            icon: const Icon(Icons.add_circle),
                            color: Colors.white,
                            iconSize: 32.0,
                          ),
                  ],
                ),
                BlocBuilder<SharedPreferencesBloc, SharedPreferencesState>(
                  builder: (context, state) {
                    if (state is SharedPreferencesLoaded) {
                      return SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 24.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Timer(const Duration(milliseconds: 700), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        KonfirmasiPesananScreen(
                                      produk: widget.produk,
                                      total: hitungTotal(widget.produk),
                                      jumlah: jumlah,
                                      user: widget.user,
                                    ),
                                  ),
                                );
                              });
                              context
                                  .read<SharedPreferencesBloc>()
                                  .add(LoadSharedPreferences());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Text(
                              'Beli',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  color: kJayaTirtaBlue300),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
