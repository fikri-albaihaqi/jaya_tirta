import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/utils/validator.dart';

class EditDataPenjualanScreen extends StatefulWidget {
  EditDataPenjualanScreen({Key? key, required this.penjualan})
      : super(key: key);

  Pesanan penjualan;

  @override
  State<EditDataPenjualanScreen> createState() =>
      _EditDataPenjualanScreenState();
}

class _EditDataPenjualanScreenState extends State<EditDataPenjualanScreen> {
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

  int hitungTotal(Produk produk) {
    return total = produk.harga! * jumlah;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    initializeDateFormatting('id-ID', '');
    String tanggal = DateFormat.yMMMMEEEEd('id-ID').format(now);
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
          title: const Text('Ubah Data Penjualan'),
        ),
        body: BlocBuilder<CrudPesananBloc, CrudPesananState>(
          builder: (context, state) {
            if (state is CrudPesananLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CrudPesananLoaded) {
              return Container(
                color: kJayaTirtaBlue50,
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
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
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state is ProdukLoaded) {
                                          dropdownValue = state.produk.first;
                                          stokBaru =
                                              dropdownValue!.stok! - jumlah;

                                          return Column(
                                            children: [
                                              DropdownButtonFormField(
                                                elevation: 16,
                                                hint:
                                                    const Text('Pilih Produk'),
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.grey,
                                                ),
                                                value: dropdownValue,
                                                onChanged: (Produk? newValue) {
                                                  setState(() {
                                                    dropdownValue = newValue!;
                                                  });
                                                },
                                                items: state.produk.map<
                                                        DropdownMenuItem<
                                                            Produk>>(
                                                    (Produk value) {
                                                  return DropdownMenuItem<
                                                      Produk>(
                                                    value: value,
                                                    child:
                                                        Text(value.namaProduk!),
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
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.grey,
                                                ),
                                                value: jumlah,
                                                onChanged: (int? newValue) {
                                                  setState(() {
                                                    jumlah = newValue!;
                                                  });
                                                },
                                                items: jumlahProduk
                                                    .map<DropdownMenuItem<int>>(
                                                        (int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child:
                                                        Text(value.toString()),
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
                                      controller: _namaKonsumenTextController,
                                      focusNode: _focusNamaKonsumen,
                                      validator: (value) =>
                                          Validator.validateNama(
                                        nama: value,
                                      ),
                                      maxLength: 25,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(25)
                                      ],
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
                                        context.read<CrudPesananBloc>().add(
                                            UpdatePesanan(namaKonsumen: value));
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _keckelurahanTextController,
                                      focusNode: _focusKeckelurahan,
                                      validator: (value) =>
                                          Validator.validateKecKelurahan(
                                        keckelurahan: value,
                                      ),
                                      maxLength: 25,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(25)
                                      ],
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
                                        context.read<CrudPesananBloc>().add(
                                            UpdatePesanan(keckelurahan: value));
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _alamatTextController,
                                      focusNode: _focusAlamat,
                                      validator: (value) =>
                                          Validator.validateAlamat(
                                        alamat: value,
                                      ),
                                      maxLength: 200,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(200)
                                      ],
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
                                            .add(UpdatePesanan(alamat: value));
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _noTelpTextController,
                                      focusNode: _focusNoTelp,
                                      keyboardType: TextInputType.number,
                                      validator: (value) =>
                                          Validator.validateNoTelpDataPenjualan(
                                        noTelp: value,
                                      ),
                                      maxLength: 13,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(13)
                                      ],
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
                                            .add(UpdatePesanan(noTelp: value));
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<CrudPesananBloc>()
                                                    .add(
                                                      UpdatePesanan(
                                                        status:
                                                            'Pesanan Selesai',
                                                        jumlah: jumlah,
                                                        total: hitungTotal(
                                                            dropdownValue!),
                                                        tanggalPembelian:
                                                            tanggal,
                                                        idProduk:
                                                            dropdownValue!.id,
                                                        namaProduk:
                                                            dropdownValue!
                                                                .namaProduk,
                                                        gambar: dropdownValue!
                                                            .gambar,
                                                        harga: dropdownValue!
                                                            .harga,
                                                        stok: stokBaru,
                                                        idKonsumen: '',
                                                        namaKonsumen:
                                                            state.namaKonsumen,
                                                        alamat: state.alamat,
                                                        noTelp: state.noTelp,
                                                        keckelurahan:
                                                            state.keckelurahan,
                                                        jumlahPinjaman: jumlah,
                                                      ),
                                                    );
                                                Timer(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  context
                                                      .read<CrudPesananBloc>()
                                                      .add(ConfirmUpdatePesanan(
                                                          id: widget
                                                              .penjualan.id,
                                                          pesanan:
                                                              state.pesanan));
                                                  context
                                                      .read<CrudProdukBloc>()
                                                      .add(UpdateStok(
                                                          id: dropdownValue!.id,
                                                          stok: stokBaru));
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                });
                                              }
                                            },
                                            child: const Text(
                                              'Simpan',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
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
        ),
      ),
    );
  }
}
