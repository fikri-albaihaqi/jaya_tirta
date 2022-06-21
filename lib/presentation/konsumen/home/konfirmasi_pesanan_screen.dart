import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/konsumen/main_screen/konsumen_main_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/data_diri_pesanan_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/edit_data_diri_pesanan.dart';
import 'package:jaya_tirta/utils/colors.dart';

class KonfirmasiPesananScreen extends StatefulWidget {
  Produk produk;
  int total;
  int jumlah;
  User? user;

  KonfirmasiPesananScreen(
      {Key? key,
      required this.produk,
      required this.total,
      required this.jumlah,
      required this.user})
      : super(key: key);

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
  Konsumen? konsumen;

  @override
  Widget build(BuildContext context) {
    int stokBaru = int.parse(widget.produk.stok!) - widget.jumlah;
    DateTime now = DateTime.now();
    initializeDateFormatting('id-ID', '');
    String tanggal = DateFormat.yMMMMEEEEd('id-ID').format(now);
    return GestureDetector(
      onTap: () {
        _focusNama.unfocus();
        _focusAlamat.unfocus();
        _focusNoTelp.unfocus();
      },
      child: Scaffold(
        backgroundColor: kJayaTirtaBackgroundWhite,
        appBar: AppBar(
          title: const Text('Pesan Produk'),
          centerTitle: true,
          backgroundColor: kJayaTirtaBlue500,
          elevation: 0.0,
        ),
        body: BlocBuilder<CrudPesananBloc, CrudPesananState>(
          builder: (context, state) {
            if (state is CrudPesananLoading) {
              return const Center(
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
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Total Pembayaran',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp ${widget.total}',
                                  style: const TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
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
                  const SizedBox(
                    height: 32.0,
                  ),
                  BlocBuilder<SharedPreferencesBloc, SharedPreferencesState>(
                    builder: (context, status) {
                      if (status is SharedPreferencesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (status is SharedPreferencesLoaded) {
                        return Builder(builder: (context) {
                          if (status.konsumen.isNotEmpty) {
                            konsumen = Konsumen(
                              id: status.konsumen.elementAt(0),
                              nama: status.konsumen.elementAt(1),
                              alamat: status.konsumen.elementAt(2),
                              noTelp: status.konsumen.elementAt(3),
                              keckelurahan: status.konsumen.elementAt(4),
                            );
                            return Container(
                              child: widget.user!.uid ==
                                      status.konsumen.elementAt(0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24.0, right: 24.0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Pastikan data sudah benar sebelum konfirmasi pesanan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Kanit',
                                                fontWeight: FontWeight.w700,
                                                color: kJayaTirtaBlack900,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 24.0,
                                            ),
                                            Text(
                                              'Nama: ${status.konsumen.elementAt(1)}',
                                              style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              'Kecamatan/Kelurahan: ${status.konsumen.elementAt(4)}',
                                              style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              'Alamat: ${status.konsumen.elementAt(2)}',
                                              style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              'Nomor Telepon: ${status.konsumen.elementAt(3)}',
                                              style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 24.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditDataDiriPesananScreen(
                                                            produk:
                                                                widget.produk,
                                                            total: widget.total,
                                                            jumlah:
                                                                widget.jumlah,
                                                            user: widget.user,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      'Ubah Data',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Card(
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 16,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'graphics/prima.png',
                                                          scale: 4,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              widget.produk
                                                                  .namaProduk!,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${widget.jumlah} x ${widget.produk.harga}',
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      'Total Harga',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Rp.${widget.total}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: BlocBuilder<
                                                      CrudKonsumenBloc,
                                                      CrudKonsumenState>(
                                                    builder:
                                                        (context, keadaan) {
                                                      if (keadaan
                                                          is CrudKonsumenLoading) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      } else if (keadaan
                                                          is CrudKonsumenLoaded) {
                                                        return ElevatedButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    CrudPesananBloc>()
                                                                .add(
                                                                  AddPesanan(
                                                                    status:
                                                                        'Menunggu Konfirmasi',
                                                                    jumlah: widget
                                                                        .jumlah
                                                                        .toString(),
                                                                    total: widget
                                                                        .total
                                                                        .toString(),
                                                                    tanggalPembelian:
                                                                        tanggal,
                                                                    idProduk:
                                                                        widget
                                                                            .produk
                                                                            .id,
                                                                    namaProduk: widget
                                                                        .produk
                                                                        .namaProduk,
                                                                    gambar: widget
                                                                        .produk
                                                                        .gambar,
                                                                    harga: widget
                                                                        .produk
                                                                        .harga,
                                                                    stok: stokBaru
                                                                        .toString(),
                                                                    idKonsumen: status
                                                                        .konsumen
                                                                        .elementAt(
                                                                            0),
                                                                    namaKonsumen: status
                                                                        .konsumen
                                                                        .elementAt(
                                                                            1),
                                                                    alamat: status
                                                                        .konsumen
                                                                        .elementAt(
                                                                            2),
                                                                    noTelp: status
                                                                        .konsumen
                                                                        .elementAt(
                                                                            3),
                                                                    keckelurahan: status
                                                                        .konsumen
                                                                        .elementAt(
                                                                            4),
                                                                    jumlahPinjaman: widget
                                                                        .jumlah
                                                                        .toString(),
                                                                  ),
                                                                );
                                                            context
                                                                .read<
                                                                    CrudKonsumenBloc>()
                                                                .add(
                                                                    UpdateKonsumen(
                                                                  id: status
                                                                      .konsumen
                                                                      .elementAt(
                                                                          0),
                                                                  nama: status
                                                                      .konsumen
                                                                      .elementAt(
                                                                          1),
                                                                  alamat: status
                                                                      .konsumen
                                                                      .elementAt(
                                                                          2),
                                                                  noTelp: status
                                                                      .konsumen
                                                                      .elementAt(
                                                                          3),
                                                                  keckelurahan: status
                                                                      .konsumen
                                                                      .elementAt(
                                                                          4),
                                                                  jumlahPinjaman:
                                                                      widget
                                                                          .jumlah
                                                                          .toString(),
                                                                ));
                                                            Timer(
                                                                const Duration(
                                                                    seconds: 1),
                                                                () {
                                                              context
                                                                  .read<
                                                                      CrudPesananBloc>()
                                                                  .add(ConfirmAddPesanan(
                                                                      pesanan: state
                                                                          .pesanan));
                                                              context
                                                                  .read<
                                                                      CrudKonsumenBloc>()
                                                                  .add(
                                                                    ConfirmUpdateKonsumen(
                                                                      konsumen:
                                                                          keadaan
                                                                              .konsumen,
                                                                      id: status
                                                                          .konsumen
                                                                          .elementAt(
                                                                              0),
                                                                    ),
                                                                  );
                                                              context
                                                                  .read<
                                                                      CrudProdukBloc>()
                                                                  .add(
                                                                    UpdateStok(
                                                                      id: widget
                                                                          .produk
                                                                          .id,
                                                                      stok: stokBaru
                                                                          .toString(),
                                                                    ),
                                                                  );
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const KonsumenMainScreen(),
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          child: const Text(
                                                            'Konfirmasi Pesanan',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        );
                                                      } else {
                                                        return const Text(
                                                            'Something went wrong');
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Yuk isi data diri terlebih dahulu dengan menekan tombol "Masukan Data Diri"',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Kanit',
                                              fontWeight: FontWeight.w700,
                                              color: kJayaTirtaBlack900,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DataDiriPesananScreen(
                                                          produk: widget.produk,
                                                          total: widget.total,
                                                          jumlah: widget.jumlah,
                                                          user: widget.user,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Masukan Data Diri',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Yuk isi data diri terlebih dahulu dengan menekan tombol "Masukan Data Diri"',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Kanit',
                                      fontWeight: FontWeight.w700,
                                      color: kJayaTirtaBlack900,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DataDiriPesananScreen(
                                                  produk: widget.produk,
                                                  total: widget.total,
                                                  jumlah: widget.jumlah,
                                                  user: widget.user,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Masukan Data Diri',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                      } else {
                        return const Text('Something went wrong');
                      }
                    },
                  ),
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
