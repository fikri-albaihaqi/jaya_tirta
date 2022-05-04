import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/data_diri_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KonfirmasiPesananScreen extends StatefulWidget {
  KonfirmasiPesananScreen(
      {Key? key,
      required this.produk,
      required this.total,
      required this.jumlah,
      required this.user})
      : super(key: key);
  Produk produk;
  int total;
  int jumlah;
  User? user;

  @override
  State<KonfirmasiPesananScreen> createState() =>
      _KonfirmasiPesananScreenState();
}

class _KonfirmasiPesananScreenState extends State<KonfirmasiPesananScreen> {
  final _focusNama = FocusNode();
  final _focusAlamat = FocusNode();
  final _focusNoTelp = FocusNode();

  String nama = '';
  String alamat = '';
  String noTelp = '';

  late final Pesanan pesanan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNama.unfocus();
        _focusAlamat.unfocus();
        _focusNoTelp.unfocus();
      },
      child: Scaffold(
        backgroundColor: kJayaTirtaBackgroundWhite,
        appBar: AppBar(
          title: Text('Pesan Produk'),
          centerTitle: true,
          backgroundColor: kJayaTirtaBlue500,
          elevation: 0.0,
        ),
        body: BlocBuilder<CrudPesananBloc, CrudPesananState>(
          builder: (context, state) {
            if (state is CrudPesananLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CrudPesananLoaded) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 150,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kJayaTirtaBlue500,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(200),
                              bottomRight: Radius.circular(200),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16.0,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Total Pembayaran',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp ${widget.total}',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Pembayaran diberikan kepada kurir ketika barang dikirim',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kJayaTirtaBlue500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  BlocBuilder<SharedPreferencesBloc, SharedPreferencesState>(
                    builder: (context, state) {
                      if (state is SharedPreferencesLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is SharedPreferencesLoaded) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Pastikan data sudah benar sebelum konfirmasi pesanan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.w700,
                                    color: kJayaTirtaBlack900,
                                  ),
                                ),
                                SizedBox(
                                  height: 24.0,
                                ),
                                Text(
                                  'Nama: ${state.konsumen.elementAt(1)}',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  'Alamat: ${state.konsumen.elementAt(2)}',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  'Nomor Telepon: ${state.konsumen.elementAt(3)}',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Text('Something went wrong');
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DataDiriScreen(user: widget.user),
                              ),
                            );
                          },
                          child: const Text(
                            'Ubah Data',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
