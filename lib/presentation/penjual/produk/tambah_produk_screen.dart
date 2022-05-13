import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/crud_produk/crud_produk_bloc.dart';
import 'package:jaya_tirta/utils/colors.dart';

import '../../../bloc/blocs.dart';

class TambahProdukScreen extends StatefulWidget {
  const TambahProdukScreen({Key? key}) : super(key: key);

  @override
  State<TambahProdukScreen> createState() => _TambahProdukScreenState();
}

class _TambahProdukScreenState extends State<TambahProdukScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaProdukTextController = TextEditingController();
  final _stokTextController = TextEditingController();
  final _hargaTextController = TextEditingController();
  final _gambarTextController = TextEditingController();

  final _focusNamaProduk = FocusNode();
  final _focusGambar = FocusNode();
  final _focusStok = FocusNode();
  final _focusHarga = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNamaProduk.unfocus();
        _focusGambar.unfocus();
        _focusStok.unfocus();
        _focusHarga.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kJayaTirtaBlue500,
          elevation: 0,
          title: const Text('Tambah Produk'),
        ),
        body: BlocBuilder<CrudProdukBloc, CrudProdukState>(
          builder: (context, state) {
            if (state is CrudProdukLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CrudProdukLoaded) {
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _namaProdukTextController,
                                    focusNode: _focusNamaProduk,
                                    decoration: InputDecoration(
                                      hintText: "Nama Produk",
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
                                          .read<CrudProdukBloc>()
                                          .add(AddProduk(namaProduk: value));
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: _gambarTextController,
                                    focusNode: _focusGambar,
                                    decoration: InputDecoration(
                                      hintText: "Gambar",
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
                                          .read<CrudProdukBloc>()
                                          .add(AddProduk(gambar: value));
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: _stokTextController,
                                    focusNode: _focusStok,
                                    decoration: InputDecoration(
                                      hintText: "Stok",
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
                                          .read<CrudProdukBloc>()
                                          .add(AddProduk(stok: value));
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: _hargaTextController,
                                    focusNode: _focusHarga,
                                    decoration: InputDecoration(
                                      hintText: "Harga",
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
                                          .read<CrudProdukBloc>()
                                          .add(AddProduk(harga: value));
                                    },
                                  ),
                                  const SizedBox(height: 24.0),
                                  Text(state.toString()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context.read<CrudProdukBloc>().add(
                                                ConfirmAddProduk(
                                                    produk: state.produk));
                                          },
                                          child: const Text(
                                            'Simpan',
                                            style:
                                                TextStyle(color: Colors.white),
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
