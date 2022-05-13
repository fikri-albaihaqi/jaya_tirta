import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/data/models/models.dart';

import '../../../bloc/blocs.dart';
import '../../../utils/colors.dart';

class EditProdukScreen extends StatefulWidget {
  EditProdukScreen({Key? key, required this.produk}) : super(key: key);
  Produk produk;

  @override
  State<EditProdukScreen> createState() => _EditProdukScreenState();
}

class _EditProdukScreenState extends State<EditProdukScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _namaProdukTextController = TextEditingController();
    final _stokTextController = TextEditingController();
    final _hargaTextController = TextEditingController();
    final _gambarTextController = TextEditingController();

    final _focusNamaProduk = FocusNode();
    final _focusGambar = FocusNode();
    final _focusStok = FocusNode();
    final _focusHarga = FocusNode();
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
          title: const Text('Edit Produk'),
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
                                          .add(UpdateProduk(namaProduk: value));
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
                                          .add(UpdateProduk(gambar: value));
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
                                          .add(UpdateProduk(stok: value));
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
                                          .add(UpdateProduk(harga: value));
                                    },
                                  ),
                                  const SizedBox(height: 24.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context.read<CrudProdukBloc>().add(
                                                ConfirmUpdateProduk(
                                                    produk: state.produk,
                                                    id: widget.produk.id));
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
