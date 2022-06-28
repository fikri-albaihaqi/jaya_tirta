import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/produk/produk_repository.dart';
import 'package:jaya_tirta/presentation/penjual/produk/produk_screen.dart';
import 'package:jaya_tirta/utils/validator.dart';

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

  ProdukRepository? produkRepository = ProdukRepository();

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

    String urlGambar = '';
    print('url: ${urlGambar}');
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Edit Data Produk',
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
                                    validator: (value) =>
                                        Validator.validateNamaProduk(
                                      namaProduk: value,
                                    ),
                                    maxLength: 30,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30)
                                    ],
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
                                          .add(UpdateProduk(namaProduk: value));
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
                                      label: const Text('Pilih Gambar')),
                                  const SizedBox(height: 16.0),
                                  urlGambar == ''
                                      ? Image.network(widget.produk.gambar!)
                                      : Image.network(urlGambar),
                                  TextFormField(
                                    controller: _stokTextController,
                                    focusNode: _focusStok,
                                    keyboardType: TextInputType.number,
                                    validator: (value) =>
                                        Validator.validateStok(
                                      stok: value,
                                    ),
                                    maxLength: 4,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4)
                                    ],
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
                                          UpdateProduk(stok: int.parse(value)));
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: _hargaTextController,
                                    focusNode: _focusHarga,
                                    keyboardType: TextInputType.number,
                                    validator: (value) =>
                                        Validator.validateHarga(
                                      harga: value,
                                    ),
                                    maxLength: 8,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(8)
                                    ],
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
                                      if (urlGambar == '') {
                                        context.read<CrudProdukBloc>().add(
                                            UpdateProduk(
                                                harga: int.parse(value),
                                                gambar: widget.produk.gambar));
                                      } else {
                                        context.read<CrudProdukBloc>().add(
                                            UpdateProduk(
                                                harga: int.parse(value),
                                                gambar: urlGambar));
                                      }
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
                                                .validate()) {
                                              context
                                                  .read<CrudProdukBloc>()
                                                  .add(
                                                    ConfirmUpdateProduk(
                                                        produk: state.produk,
                                                        id: widget.produk.id),
                                                  );
                                              Navigator.popUntil(context,
                                                  (route) => route.isFirst);
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
                                  ),
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
