import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/penjual/main_screen/main_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/utils/validator.dart';

class EditDataPenjualScreen extends StatefulWidget {
  EditDataPenjualScreen({Key? key, required this.user}) : super(key: key);

  User? user;

  @override
  State<EditDataPenjualScreen> createState() => _EditDataPenjualScreenState();
}

class _EditDataPenjualScreenState extends State<EditDataPenjualScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaTextController = TextEditingController();
  final _noTelpTextController = TextEditingController();

  final _focusNama = FocusNode();
  final _focusNoTelp = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNama.unfocus();
        _focusNoTelp.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kJayaTirtaBlue500,
          title: const Text('Data Diri'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<CrudPenjualBloc, CrudPenjualState>(
            builder: (context, state) {
              if (state is CrudPenjualLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CrudPenjualLoaded) {
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
                              'Ubah Data Penjual',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
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
                                const SizedBox(height: 16.0),
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
                                        .read<CrudPenjualBloc>()
                                        .add(UpdatePenjual(nama: value));
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
                                    context.read<CrudPenjualBloc>().add(
                                          UpdatePenjual(
                                              noTelp: value,
                                              id: widget.user!.uid),
                                        );
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
                                            context.read<CrudPenjualBloc>().add(
                                                  ConfirmUpdatePenjual(
                                                    penjual: state.penjual,
                                                    id: widget.user!.uid,
                                                  ),
                                                );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen()),
                                            );
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
