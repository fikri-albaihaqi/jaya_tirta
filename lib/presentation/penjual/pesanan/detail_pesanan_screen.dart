import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/utils/colors.dart';

class DetailPesananScreen extends StatefulWidget {
  DetailPesananScreen({Key? key, required this.pesanan}) : super(key: key);
  Pesanan pesanan;

  @override
  State<DetailPesananScreen> createState() => _DetailPesananScreenState();
}

class _DetailPesananScreenState extends State<DetailPesananScreen> {
  String dropdownValue = 'Pesanan Diproses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue500,
      appBar: AppBar(
        backgroundColor: kJayaTirtaBlue500,
        title: const Text('Detail Pesanan'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
            ),
          ),
        ],
      ),
      body: BlocBuilder<CrudPesananBloc, CrudPesananState>(
        builder: (context, state) {
          if (state is CrudPesananLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CrudPesananLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      const Divider(
                                        height: 108,
                                        color: Colors.grey,
                                        thickness: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.inventory_2_outlined,
                                                size: 40,
                                              ),
                                              Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.greenAccent,
                                              ),
                                              Text(
                                                'Pesanan Sedang \n Diproses',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.local_shipping_outlined,
                                                size: 40,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                'Pesanan Sedang \n Dikirim',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.done_outlined,
                                                size: 40,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                'Pesanan Selesai',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Ubah status pesanan',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    DropdownButtonFormField(
                      elevation: 16,
                      decoration: const InputDecoration(
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
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Pesanan Diproses',
                        'Pesanan Dikirim',
                        'Pesanan Selesai'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Tanggal Pembelian',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                    Icon(Icons.date_range_outlined),
                                  ],
                                ),
                                Text(
                                  '22 Mei 2022',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Alamat',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                    Icon(Icons.location_on_outlined),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.pesanan.namaKonsumen} (${widget.pesanan.noTelp})',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.pesanan.alamat!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Detail Pesanan',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'graphics/prima.png',
                                  scale: 4,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.pesanan.namaProduk!,
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${widget.pesanan.jumlah} x ${widget.pesanan.harga}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Harga',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Rp.${widget.pesanan.total}',
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CrudPesananBloc>().add(UpdatePesanan(
                                    id: widget.pesanan.id,
                                    status: dropdownValue,
                                    jumlah: widget.pesanan.jumlah,
                                    total: widget.pesanan.total,
                                    idProduk: widget.pesanan.idProduk,
                                    namaProduk: widget.pesanan.namaProduk,
                                    gambar: widget.pesanan.gambar,
                                    harga: widget.pesanan.harga,
                                    stok: widget.pesanan.stok,
                                    idKonsumen: widget.pesanan.idKonsumen,
                                    namaKonsumen: widget.pesanan.namaKonsumen,
                                    alamat: widget.pesanan.alamat,
                                    noTelp: widget.pesanan.noTelp,
                                  ));
                              context.read<CrudPesananBloc>().add(
                                    ConfirmUpdatePesanan(
                                        pesanan: state.pesanan,
                                        id: widget.pesanan.id),
                                  );
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
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
