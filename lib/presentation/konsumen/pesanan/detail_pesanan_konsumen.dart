import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/utils/colors.dart';

class DetailPesananKonsumenScreen extends StatefulWidget {
  DetailPesananKonsumenScreen({Key? key, required this.pesanan})
      : super(key: key);
  Pesanan pesanan;

  @override
  State<DetailPesananKonsumenScreen> createState() =>
      _DetailPesananKonsumenScreenState();
}

class _DetailPesananKonsumenScreenState
    extends State<DetailPesananKonsumenScreen> {
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
            icon: const Icon(
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
                              children: const [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  size: 40,
                                ),
                                Icon(
                                  Icons.local_shipping_outlined,
                                  size: 40,
                                ),
                                Icon(
                                  Icons.done_outlined,
                                  size: 40,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Builder(builder: (context) {
                                if (widget.pesanan.status ==
                                    'Pesanan Diproses') {
                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8, top: 12),
                                            child: Container(
                                              height: 1.0,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.green,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        '${widget.pesanan.status}',
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (widget.pesanan.status ==
                                    'Pesanan Dikirim') {
                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8, top: 12),
                                            child: Container(
                                              height: 1.0,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.green,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        '${widget.pesanan.status}',
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  );
                                } else if (widget.pesanan.status ==
                                    'Pesanan Selesai') {
                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8, top: 12),
                                            child: Container(
                                              height: 1.0,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        '${widget.pesanan.status}',
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  );
                                } else if (widget.pesanan.status ==
                                    'Pesanan Dibatalkan') {
                                  return const Text(
                                    'Pesanan Dibatalkan',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kJayaTirtaErrorRed,
                                    ),
                                  );
                                } else if (widget.pesanan.status ==
                                    'Menunggu Konfirmasi') {
                                  return const Text(
                                    'Menunggu Konfirmasi',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    'Something went worng',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              }),
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
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(Icons.date_range_outlined),
                                  ],
                                ),
                                Text(
                                  '${widget.pesanan.tanggalPembelian}',
                                  style: const TextStyle(
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
                            style:
                                widget.pesanan.status == 'Menunggu Konfirmasi'
                                    ? ElevatedButton.styleFrom(
                                        primary: kJayaTirtaErrorRed)
                                    : ElevatedButton.styleFrom(
                                        primary: Colors.grey,
                                        splashFactory: NoSplash.splashFactory,
                                      ),
                            onPressed: () {
                              widget.pesanan.status == 'Menunggu Konfirmasi'
                                  ? showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title:
                                                const Text('Batalkan Pesanan'),
                                            content: const Text(
                                                'Apakah anda yakin akan membatalkan pesanan ini?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Batal'),
                                                  child: const Text('Batal')),
                                              TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<CrudPesananBloc>()
                                                      .add(UpdatePesanan(
                                                        id: widget.pesanan.id,
                                                        status:
                                                            'Pesanan Dibatalkan',
                                                        jumlah: widget
                                                            .pesanan.jumlah,
                                                        total: widget
                                                            .pesanan.total,
                                                        keckelurahan: widget
                                                            .pesanan
                                                            .keckelurahan,
                                                        idProduk: widget
                                                            .pesanan.idProduk,
                                                        namaProduk: widget
                                                            .pesanan.namaProduk,
                                                        gambar: widget
                                                            .pesanan.gambar,
                                                        harga: widget
                                                            .pesanan.harga,
                                                        stok:
                                                            widget.pesanan.stok,
                                                        idKonsumen: widget
                                                            .pesanan.idKonsumen,
                                                        namaKonsumen: widget
                                                            .pesanan
                                                            .namaKonsumen,
                                                        alamat: widget
                                                            .pesanan.alamat,
                                                        noTelp: widget
                                                            .pesanan.noTelp,
                                                      ));
                                                  context
                                                      .read<CrudPesananBloc>()
                                                      .add(
                                                        ConfirmUpdatePesanan(
                                                          pesanan:
                                                              state.pesanan,
                                                          id: widget.pesanan.id,
                                                        ),
                                                      );
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                },
                                                child: const Text(
                                                  'Batalkan Pesanan',
                                                ),
                                              ),
                                            ],
                                          ))
                                  : null;
                            },
                            child: const Text(
                              'Batalkan Pesanan',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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
