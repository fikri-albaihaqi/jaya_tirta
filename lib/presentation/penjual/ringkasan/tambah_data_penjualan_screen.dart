import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/penjualan_bulanan/penjualan_bulanan_repository.dart';
import 'package:jaya_tirta/presentation/penjual/main_screen/main_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jaya_tirta/utils/validator.dart';

class TambahDataPenjualanScreen extends StatefulWidget {
  const TambahDataPenjualanScreen({Key? key}) : super(key: key);

  @override
  State<TambahDataPenjualanScreen> createState() =>
      _TambahDataPenjualanScreenState();
}

class _TambahDataPenjualanScreenState extends State<TambahDataPenjualanScreen> {
  List<int> jumlahProduk = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];

  final _formKey = GlobalKey<FormState>();

  final _namaKonsumenTextController = TextEditingController();
  final _keckelurahanTextController = TextEditingController();
  final _alamatTextController = TextEditingController();
  final _noTelpTextController = TextEditingController();

  final _focusNamaKonsumen = FocusNode();
  final _focusKeckelurahan = FocusNode();
  final _focusAlamat = FocusNode();
  final _focusNoTelp = FocusNode();

  int jumlah = 1;
  int total = 0;
  int stokBaru = 0;

  Produk? dropdownValue;
  PenjualanBulananRepository penjualanBulananRepository =
      PenjualanBulananRepository();

  int hitungTotal(Produk produk) {
    return total = produk.harga! * jumlah;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    initializeDateFormatting('id-ID', '');
    String tanggal = DateFormat.yMMMMEEEEd('id-ID').format(now);
    String bulan = DateFormat('y-MM').format(now);
    String bulanTanggal = DateFormat('y-MM-d').format(now);
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String timestampString = timestamp.toString();
    return GestureDetector(
      onTap: () {
        _focusNamaKonsumen.unfocus();
        _focusKeckelurahan.unfocus();
        _focusAlamat.unfocus();
        _focusNoTelp.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kJayaTirtaBlue500,
          elevation: 0,
          title: const Text('Tambah Data Penjualan'),
        ),
        body: BlocBuilder<CrudPesananBloc, CrudPesananState>(
          builder: (context, state) {
            if (state is CrudPesananLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CrudPesananLoaded) {
              return BlocBuilder<PenjualanBulananBloc, PenjualanBulananState>(
                builder: (context, status) {
                  if (status is PenjualanBulananLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (status is PenjualanBulananLoaded) {
                    return Container(
                      color: kJayaTirtaBlue50,
                      child: ListView(
                        children: [
                          // Text(status.penjualanBulanan.tanggal.toString()),
                          // Text(bulan),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 24.0, right: 24.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Text(
                                      'Masukan Data Penjualan',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: kJayaTirtaBlack900,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          BlocBuilder<ProdukBloc, ProdukState>(
                                            builder: (context, state) {
                                              if (state is ProdukLoading) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (state
                                                  is ProdukLoaded) {
                                                dropdownValue =
                                                    state.produk.first;
                                                stokBaru =
                                                    dropdownValue!.stok! -
                                                        jumlah;

                                                return Column(
                                                  children: [
                                                    DropdownButtonFormField(
                                                      elevation: 16,
                                                      hint: const Text(
                                                          'Pilih Produk'),
                                                      decoration:
                                                          const InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      icon: const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.grey,
                                                      ),
                                                      value: dropdownValue,
                                                      onChanged:
                                                          (Produk? newValue) {
                                                        setState(() {
                                                          dropdownValue =
                                                              newValue!;
                                                        });
                                                      },
                                                      items: state.produk.map<
                                                              DropdownMenuItem<
                                                                  Produk>>(
                                                          (Produk value) {
                                                        return DropdownMenuItem<
                                                            Produk>(
                                                          value: value,
                                                          child: Text(value
                                                              .namaProduk!),
                                                        );
                                                      }).toList(),
                                                    ),
                                                    const SizedBox(
                                                      height: 24,
                                                    ),
                                                    DropdownButtonFormField(
                                                      elevation: 16,
                                                      hint: const Text(
                                                          'Jumlah Pesanan'),
                                                      decoration:
                                                          const InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      icon: const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.grey,
                                                      ),
                                                      value: jumlah,
                                                      onChanged:
                                                          (int? newValue) {
                                                        setState(() {
                                                          jumlah = newValue!;
                                                        });
                                                      },
                                                      items: jumlahProduk.map<
                                                              DropdownMenuItem<
                                                                  int>>(
                                                          (int value) {
                                                        return DropdownMenuItem<
                                                            int>(
                                                          value: value,
                                                          child: Text(
                                                              value.toString()),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return const Text(
                                                    'Something went wrong');
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          TextFormField(
                                            controller:
                                                _namaKonsumenTextController,
                                            focusNode: _focusNamaKonsumen,
                                            maxLength: 25,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  25)
                                            ],
                                            validator: (value) =>
                                                Validator.validateNama(
                                              nama: value,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Nama Konsumen",
                                              counterText: '',
                                              errorBorder: UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              context
                                                  .read<CrudPesananBloc>()
                                                  .add(AddPesanan(
                                                      namaKonsumen: value));
                                            },
                                          ),
                                          const SizedBox(height: 8.0),
                                          TextFormField(
                                            controller:
                                                _keckelurahanTextController,
                                            focusNode: _focusKeckelurahan,
                                            maxLength: 25,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  25)
                                            ],
                                            validator: (value) =>
                                                Validator.validateKecKelurahan(
                                              keckelurahan: value,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Kecamatan/Kelurahan",
                                              counterText: '',
                                              errorBorder: UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              context
                                                  .read<CrudPesananBloc>()
                                                  .add(AddPesanan(
                                                      keckelurahan: value));
                                            },
                                          ),
                                          const SizedBox(height: 8.0),
                                          TextFormField(
                                            controller: _alamatTextController,
                                            focusNode: _focusAlamat,
                                            maxLength: 200,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  200)
                                            ],
                                            validator: (value) =>
                                                Validator.validateAlamat(
                                              alamat: value,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Alamat",
                                              counterText: '',
                                              errorBorder: UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              context
                                                  .read<CrudPesananBloc>()
                                                  .add(AddPesanan(
                                                      alamat: value));
                                            },
                                          ),
                                          const SizedBox(height: 8.0),
                                          TextFormField(
                                            controller: _noTelpTextController,
                                            focusNode: _focusNoTelp,
                                            keyboardType: TextInputType.number,
                                            maxLength: 13,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  13)
                                            ],
                                            validator: (value) => Validator
                                                .validateNoTelpDataPenjualan(
                                              noTelp: value,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Nomor Telepon",
                                              counterText: '',
                                              errorBorder: UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              context
                                                  .read<CrudPesananBloc>()
                                                  .add(AddPesanan(
                                                      noTelp: value));
                                            },
                                          ),
                                          const SizedBox(height: 8.0),
                                          const Text(
                                            'Jika tidak mengetahui nomor telepon konsumen isi dengan -',
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 24.0),
                                          BlocBuilder<CrudPenjualanBulananBloc,
                                              CrudPenjualanBulananState>(
                                            builder: (context, keadaan) {
                                              if (keadaan
                                                  is CrudPenjualanBulananLoading) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (keadaan
                                                  is CrudPenjualanBulananLoaded) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            context
                                                                .read<
                                                                    CrudPesananBloc>()
                                                                .add(
                                                                  AddPesanan(
                                                                    status:
                                                                        'Pesanan Selesai',
                                                                    jumlah:
                                                                        jumlah,
                                                                    total: hitungTotal(
                                                                        dropdownValue!),
                                                                    tanggalPembelian:
                                                                        tanggal,
                                                                    timestamp:
                                                                        timestampString,
                                                                    dateSort:
                                                                        bulanTanggal,
                                                                    idProduk:
                                                                        dropdownValue!
                                                                            .id,
                                                                    namaProduk:
                                                                        dropdownValue!
                                                                            .namaProduk,
                                                                    gambar: dropdownValue!
                                                                        .gambar,
                                                                    harga: dropdownValue!
                                                                        .harga,
                                                                    stok:
                                                                        stokBaru,
                                                                    idKonsumen:
                                                                        '',
                                                                    namaKonsumen:
                                                                        state
                                                                            .namaKonsumen,
                                                                    alamat: state
                                                                        .alamat,
                                                                    noTelp: state
                                                                        .noTelp,
                                                                    keckelurahan:
                                                                        state
                                                                            .keckelurahan,
                                                                    jumlahPinjaman:
                                                                        jumlah,
                                                                  ),
                                                                );
                                                            if (bulan !=
                                                                status
                                                                    .penjualanBulanan
                                                                    .tanggal) {
                                                              context
                                                                  .read<
                                                                      CrudPenjualanBulananBloc>()
                                                                  .add(
                                                                    AddPenjualanBulanan(
                                                                      tanggal:
                                                                          bulan,
                                                                      jumlahPenjualan:
                                                                          jumlah,
                                                                    ),
                                                                  );
                                                            }
                                                            Timer(
                                                                const Duration(
                                                                    seconds: 1),
                                                                () {
                                                              context
                                                                  .read<
                                                                      CrudPesananBloc>()
                                                                  .add(
                                                                    ConfirmAddPesanan(
                                                                        pesanan:
                                                                            state.pesanan),
                                                                  );
                                                              if (bulan !=
                                                                  status
                                                                      .penjualanBulanan
                                                                      .tanggal) {
                                                                context
                                                                    .read<
                                                                        CrudPenjualanBulananBloc>()
                                                                    .add(
                                                                      ConfirmAddPenjualanBulanan(
                                                                          penjualanBulanan:
                                                                              keadaan.penjualanBulanan!),
                                                                    );
                                                              } else if (bulan ==
                                                                  status
                                                                      .penjualanBulanan
                                                                      .tanggal) {
                                                                context
                                                                    .read<
                                                                        CrudPenjualanBulananBloc>()
                                                                    .add(
                                                                      UpdateJumlahPenjualan(
                                                                          id: status
                                                                              .penjualanBulanan
                                                                              .id,
                                                                          jumlahPenjualan:
                                                                              status.penjualanBulanan.jumlahPenjualan! + jumlah),
                                                                    );
                                                              }
                                                              context
                                                                  .read<
                                                                      CrudProdukBloc>()
                                                                  .add(UpdateStok(
                                                                      id: dropdownValue!
                                                                          .id,
                                                                      stok:
                                                                          stokBaru));
                                                              Navigator.popUntil(
                                                                  context,
                                                                  (route) => route
                                                                      .isFirst);
                                                            });
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Simpan',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return const Text(
                                                    'Something went wrong');
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    )
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
