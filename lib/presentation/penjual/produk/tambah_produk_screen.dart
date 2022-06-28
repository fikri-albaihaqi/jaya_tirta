import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/crud_produk/crud_produk_bloc.dart';
import 'package:jaya_tirta/data/repositories/produk/produk_repository.dart';
import 'package:jaya_tirta/presentation/penjual/main_screen/main_screen.dart';
import 'package:jaya_tirta/presentation/penjual/produk/produk_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/utils/validator.dart';

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

  final _focusNamaProduk = FocusNode();
  final _focusStok = FocusNode();
  final _focusHarga = FocusNode();

  ProdukRepository? produkRepository = ProdukRepository();

  @override
  Widget build(BuildContext context) {
    String urlGambar = '';
    String defaultImage =
        'https://firebasestorage.googleapis.com/v0/b/jaya-tirta.appspot.com/o/emptyimage.png?alt=media&token=ac734b03-adee-4257-ab7f-50998d0152d1';
    return GestureDetector(
      onTap: () {
        _focusNamaProduk.unfocus();
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Masukan Data Produk',
                              style: TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 24,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    controller: _namaProdukTextController,
                                    focusNode: _focusNamaProduk,
                                    maxLength: 30,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30)
                                    ],
                                    validator: (value) =>
                                        Validator.validateNamaProduk(
                                      namaProduk: value,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Nama Produk",
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
                                          .read<CrudProdukBloc>()
                                          .add(AddProduk(namaProduk: value));
                                    },
                                  ),
                                  const SizedBox(height: 24.0),
                                  const Text(
                                    'Gambar Produk',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      urlGambar = await produkRepository!
                                          .uploadImage('galery');

                                      context.read<CrudProdukBloc>().add(
                                            AddProduk(
                                              gambar: urlGambar,
                                            ),
                                          );
                                    },
                                    icon: const Icon(Icons.library_add),
                                    label: const Text('Pilih Gambar'),
                                  ),
                                  urlGambar == ''
                                      ? Image.network(
                                          defaultImage,
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              urlGambar,
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _stokTextController,
                                    focusNode: _focusStok,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4)
                                    ],
                                    validator: (value) =>
                                        Validator.validateStok(stok: value),
                                    decoration: InputDecoration(
                                      hintText: "Stok",
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
                                      context.read<CrudProdukBloc>().add(
                                          AddProduk(stok: int.parse(value)));
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: _hargaTextController,
                                    focusNode: _focusHarga,
                                    keyboardType: TextInputType.number,
                                    maxLength: 8,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(8)
                                    ],
                                    validator: (value) =>
                                        Validator.validateHarga(harga: value),
                                    decoration: InputDecoration(
                                      hintText: "Harga",
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
                                      context.read<CrudProdukBloc>().add(
                                          AddProduk(
                                              harga: int.parse(value),
                                              gambar: urlGambar));
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
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                state.gambar!.isNotEmpty) {
                                              context
                                                  .read<CrudProdukBloc>()
                                                  .add(
                                                    ConfirmAddProduk(
                                                        produk: state.produk),
                                                  );
                                              Navigator.popUntil(context,
                                                  (route) => route.isFirst);
                                            } else if (state.gambar!.isEmpty) {
                                              final snackBar = SnackBar(
                                                  content: Text(
                                                      'Produk belum memiliki gambar!'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
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
                            ),
                            const SizedBox(
                              height: 24,
                            ),
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
