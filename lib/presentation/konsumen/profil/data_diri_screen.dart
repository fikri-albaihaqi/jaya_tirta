import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/konsumen/home/konfirmasi_pesanan_screen.dart';
import 'package:jaya_tirta/presentation/konsumen/profil/profil_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class DataDiriScreen extends StatefulWidget {
  User? user;

  DataDiriScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<DataDiriScreen> createState() => _DataDiriScreenState();
}

class _DataDiriScreenState extends State<DataDiriScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaTextController = TextEditingController();
  final _alamatTextController = TextEditingController();
  final _noTelpTextController = TextEditingController();

  final _focusNama = FocusNode();
  final _focusAlamat = FocusNode();
  final _focusNoTelp = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNama.unfocus();
        _focusAlamat.unfocus();
        _focusNoTelp.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kJayaTirtaBlue500,
          title: const Text('Data Diri'),
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
                                const SizedBox(height: 16.0),
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
                                const SizedBox(height: 16.0),
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
                                    context.read<CrudKonsumenBloc>().add(
                                        AddKonsumen(
                                            noTelp: value,
                                            id: widget.user!.uid));
                                  },
                                ),
                                const SizedBox(
                                  height: 24.0,
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
                                                    konsumen: state.konsumen),
                                              );
                                          Timer(
                                              const Duration(milliseconds: 700),
                                              () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilScreen(
                                                        user: widget.user),
                                              ),
                                            );
                                            context
                                                .read<SharedPreferencesBloc>()
                                                .add(LoadSharedPreferences());
                                          });
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
