import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/utils/colors.dart';

class KonfirmasiPesananScreen extends StatefulWidget {
  KonfirmasiPesananScreen({Key? key, required this.produk}) : super(key: key);
  Produk produk;

  @override
  State<KonfirmasiPesananScreen> createState() =>
      _KonfirmasiPesananScreenState();
}

class _KonfirmasiPesananScreenState extends State<KonfirmasiPesananScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaTextController = TextEditingController();
  final _alamatTextController = TextEditingController();
  final _noTelpTextController = TextEditingController();

  final _focusNama = FocusNode();
  final _focusAlamat = FocusNode();
  final _focusNoTelp = FocusNode();

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
        body: BlocBuilder<CrudKonsumenBloc, CrudKonsumenState>(
          builder: (context, state) {
            if (state is CrudKonsumenLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CrudKonsumenLoaded) {
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
                                  'Rp 17.0000',
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
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Isi data di bawah ini dan pastikan data sudah benar sebelum konfirmasi pesanan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w700,
                              color: kJayaTirtaBlack900,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _namaTextController,
                                focusNode: _focusNama,
                                decoration: InputDecoration(
                                  hintText: "Nama",
                                  errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<CrudKonsumenBloc>()
                                      .add(AddKonsumen(nama: value));
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _alamatTextController,
                                focusNode: _focusAlamat,
                                decoration: InputDecoration(
                                  hintText: "Alamat",
                                  errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<CrudKonsumenBloc>()
                                      .add(AddKonsumen(alamat: value));
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _noTelpTextController,
                                focusNode: _focusNoTelp,
                                decoration: InputDecoration(
                                  hintText: "Nomor Telepon",
                                  errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<CrudKonsumenBloc>()
                                      .add(AddKonsumen(noTelp: value));
                                },
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 16.0,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'graphics/prima.png',
                                        scale: 3.5,
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.produk.namaProduk!,
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '1 x Rp ${widget.produk.harga}',
                                            style: TextStyle(
                                              fontFamily: 'Kanit',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<CrudKonsumenBloc>().add(
                                            ConfirmAddKonsumen(
                                                konsumen: state.konsumen));
                                      },
                                      child: const Text(
                                        'Simpan',
                                        style: TextStyle(color: Colors.white),
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
