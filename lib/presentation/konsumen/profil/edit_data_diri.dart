import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/konsumen/home/konfirmasi_pesanan_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/main_screen/konsumen_main_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/utils/validator.dart';

class EditDataDiriScreen extends StatefulWidget {
  EditDataDiriScreen({Key? key, required this.user, required this.konsumen})
      : super(key: key);

  User? user;
  List<Konsumen> konsumen;

  @override
  State<EditDataDiriScreen> createState() => _EditDataDiriScreenState();
}

class _EditDataDiriScreenState extends State<EditDataDiriScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaTextController = TextEditingController();
  final _keckelurahanTextController = TextEditingController();
  final _alamatTextController = TextEditingController();
  final _noTelpTextController = TextEditingController();

  final _focusNama = FocusNode();
  final _focusKeckelurahan = FocusNode();
  final _focusAlamat = FocusNode();
  final _focusNoTelp = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNama.unfocus();
        _focusKeckelurahan.unfocus();
        _focusAlamat.unfocus();
        _focusNoTelp.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kJayaTirtaBlue500,
          title: const Text('Ubah Data Diri'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<CrudKonsumenBloc, CrudKonsumenState>(
            builder: (context, state) {
              if (state is CrudKonsumenLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CrudKonsumenLoaded) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
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
                              'Isi data di bawah ini dan pastikan data sudah benar',
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
                                  maxLength: 25,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25)
                                  ],
                                  validator: (value) => Validator.validateNama(
                                    nama: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Nama",
                                    counterText: '',
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
                                        .add(UpdateKonsumen(nama: value));
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _keckelurahanTextController,
                                  focusNode: _focusKeckelurahan,
                                  maxLength: 25,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25)
                                  ],
                                  validator: (value) =>
                                      Validator.validateKecKelurahan(
                                    keckelurahan: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Kecamatan/Kelurahan",
                                    counterText: '',
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    context.read<CrudKonsumenBloc>().add(
                                        UpdateKonsumen(keckelurahan: value));
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _alamatTextController,
                                  focusNode: _focusAlamat,
                                  maxLength: 200,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(200)
                                  ],
                                  validator: (value) =>
                                      Validator.validateAlamat(
                                    alamat: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Alamat",
                                    counterText: '',
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
                                        .add(UpdateKonsumen(alamat: value));
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _noTelpTextController,
                                  focusNode: _focusNoTelp,
                                  keyboardType: TextInputType.number,
                                  maxLength: 13,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(13)
                                  ],
                                  validator: (value) =>
                                      Validator.validateNoTelp(
                                    noTelp: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Nomor Telepon",
                                    counterText: '',
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    context.read<CrudKonsumenBloc>().add(
                                        UpdateKonsumen(
                                            noTelp: value,
                                            id: widget.user!.uid));
                                  },
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<CrudKonsumenBloc>()
                                                .add(
                                                  ConfirmUpdateKonsumen(
                                                    konsumen: state.konsumen,
                                                    id: widget.user!.uid,
                                                  ),
                                                );
                                            Navigator.popUntil(context,
                                                (route) => route.isFirst);
                                          }
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
                return const Text('Something went wrong');
              }
            },
          ),
        ),
      ),
    );
  }
}
