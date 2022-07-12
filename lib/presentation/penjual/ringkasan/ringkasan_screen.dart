import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/repositories/pesanan/pesanan_repository.dart';
import 'package:jaya_tirta/presentation/penjual/ringkasan/detail_data_penjualan_screen.dart';
import 'package:jaya_tirta/presentation/penjual/ringkasan/tambah_data_penjualan_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:jaya_tirta/widgets/search_box.dart';

class RingkasanScreen extends StatefulWidget {
  const RingkasanScreen({Key? key}) : super(key: key);

  @override
  State<RingkasanScreen> createState() => _RingkasanScreenState();
}

class _RingkasanScreenState extends State<RingkasanScreen> {
  String dropdownValue = 'Bulanan';

  @override
  Widget build(BuildContext context) {
    PesananRepository pesananRepository = PesananRepository();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: kJayaTirtaBlue500,
            bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Riwayat Penjualan'),
                Tab(text: 'Ramalan Penjualan'),
                Tab(text: 'Data Konsumen'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Riwayat Penjualan',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: kJayaTirtaBlack900,
                    ),
                  ),
                  BlocBuilder<PesananBloc, PesananState>(
                    builder: (context, state) {
                      context.read<PesananBloc>()..add(LoadRiwayatPesanan());
                      if (state is PesananLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is PesananLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TambahDataPenjualanScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Tambah Data Penjualan',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const SearchBox(),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pesananRepository
                                        .saveDataPenjualan(state.pesanan);
                                  },
                                  child: const Text(
                                    'Download Data Penjualan',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.pesanan.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailDataPenjualanScreen(
                                            penjualan: state.pesanan[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 16,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${state.pesanan[index].tanggalPembelian}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              height: 16,
                                            ),
                                            Row(
                                              children: [
                                                Image.network(
                                                  state.pesanan[index].gambar!,
                                                  scale: 7,
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Nama: ${state.pesanan[index].namaKonsumen}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'No Telp: ${state.pesanan[index].noTelp}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Kec/Kel: ${state.pesanan[index].keckelurahan}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Alamat: ${state.pesanan[index].alamat}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Produk: ${state.pesanan[index].namaProduk}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Jumlah: ${state.pesanan[index].jumlah}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Total Harga: Rp.${state.pesanan[index].total}',
                                              style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Text('Something went wrong');
                      }
                    },
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: BlocBuilder<PeramalanBulananBloc, PeramalanBulananState>(
                builder: (context, state) {
                  DateTime now = DateTime.now();
                  initializeDateFormatting('id-ID', '');
                  if (state is PeramalanBulananLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PeramalanBulananLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              const Text(
                                'Lihat Peramalan Penjualan Untuk',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
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
                                  'Bulanan',
                                  'Mingguan',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Builder(builder: (context) {
                          if (dropdownValue == 'Bulanan') {
                            return Column(
                              children: [
                                BlocBuilder<PeramalanBulananBloc,
                                    PeramalanBulananState>(
                                  builder: (context, state) {
                                    if (state is PeramalanBulananLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state
                                        is PeramalanBulananLoaded) {
                                      if (state.peramalan.isEmpty) {
                                        return const Text(
                                            'Data Peramalan Tidak Tersedia');
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              const Text(
                                                'Perkiraan Total Penjualan Untuk 12 Bulan Selanjutnya',
                                                style: TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                itemCount:
                                                    state.peramalan.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListTile(
                                                    hoverColor: Colors.grey,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            top: 0, bottom: 0),
                                                    title: Text(
                                                      'Bulan ke: ${state.peramalan[index].bulan!.substring(0, 7)}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    trailing: Text(
                                                      '${state.peramalan[index].hasilRamal!.ceil()} galon',
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        const Divider(),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    } else {
                                      return const Text('Something went wrong');
                                    }
                                  },
                                ),
                              ],
                            );
                          } else if (dropdownValue == 'Mingguan') {
                            return Column(
                              children: [
                                BlocBuilder<PeramalanMingguanBloc,
                                    PeramalanMingguanState>(
                                  builder: (context, state) {
                                    if (state is PeramalanMingguanLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state
                                        is PeramalanMingguanLoaded) {
                                      if (state.peramalan.isEmpty) {
                                        return const Text(
                                            'Data Peramalan Tidak Tersedia');
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              const Text(
                                                'Perkiraan Total Penjualan Setiap Minggu Pada Bulan Ini',
                                                style: TextStyle(
                                                  fontFamily: 'Kanit',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                itemCount: 1,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Text(
                                                    '${state.peramalan[index].hasilRamal!.ceil()} galon',
                                                    style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        const Divider(),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    } else {
                                      return const Text('Something went wrong');
                                    }
                                  },
                                ),
                              ],
                            );
                          } else {
                            return const Text('Something went wrong');
                          }
                        }),
                      ],
                    );
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data Konsumen',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    BlocBuilder<KonsumenBloc, KonsumenState>(
                      builder: (context, state) {
                        context.read<KonsumenBloc>()..add(LoadAllKonsumen());
                        if (state is KonsumenLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is KonsumenLoaded) {
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16),
                            itemCount: state.konsumen.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                hoverColor: Colors.grey,
                                contentPadding:
                                    const EdgeInsets.only(top: 0, bottom: 0),
                                leading: Text(
                                  '${state.konsumen[index].nama}',
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.konsumen[index].alamat}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${state.konsumen[index].noTelp}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Jumlah Pinjaman: ${state.konsumen[index].jumlahPinjaman}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text('Hapus data konsumen'),
                                          content: Text(
                                              'Apakah anada yakin akan menghapus data konsumen ${state.konsumen[index].nama}?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Batal'),
                                                child: const Text('Batal')),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'Hapus');
                                                context
                                                    .read<CrudKonsumenBloc>()
                                                    .add(
                                                      DeleteKonsumen(
                                                          id: state
                                                              .konsumen[index]
                                                              .id!),
                                                    );
                                              },
                                              child: const Text(
                                                'Hapus',
                                                style: TextStyle(
                                                    color: kJayaTirtaErrorRed),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_outlined,
                                      color: kJayaTirtaErrorRed,
                                      size: 28,
                                    )),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          );
                        } else {
                          return const Text('Something went wrong');
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
