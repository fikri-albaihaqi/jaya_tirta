import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/penjual/pesanan/detail_pesanan_screen.dart';
import 'package:jaya_tirta/presentation/penjual/ringkasan/tambah_data_penjualan_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class RingkasanScreen extends StatefulWidget {
  const RingkasanScreen({Key? key}) : super(key: key);

  @override
  State<RingkasanScreen> createState() => _RingkasanScreenState();
}

class _RingkasanScreenState extends State<RingkasanScreen> {
  String dropdownValue = 'Bulanan';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: kJayaTirtaBlue500,
            bottom: TabBar(
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
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 32.0, right: 32.0, top: 24.0),
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
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16),
                              itemCount: state.pesanan.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPesananScreen(
                                          pesanan: state.pesanan[index],
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${state.pesanan[index].tanggalPembelian}',
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                state.pesanan[index].status!,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                state.pesanan[index].gambar!,
                                                scale: 2.8,
                                              ),
                                              const SizedBox(
                                                width: 8,
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
                                                    'No Telepon: ${state.pesanan[index].noTelp}',
                                                    style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Kecamatan/Kelurahan: ${state.pesanan[index].keckelurahan}',
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
              child: Column(
                children: [
                  BlocBuilder<PeramalanBloc, PeramalanState>(
                    builder: (context, state) {
                      if (state is PeramalanLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PeramalanLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(16),
                                itemCount: state.peramalan.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    hoverColor: Colors.grey,
                                    contentPadding:
                                        EdgeInsets.only(top: 0, bottom: 0),
                                    title: Text(
                                      'Bulan ke: ${state.peramalan[index].bulanKe}',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: Text(
                                      '${state.peramalan[index].hasilRamal!.toInt()} galon',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
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
                                    EdgeInsets.only(top: 0, bottom: 0),
                                leading: Text(
                                  '${state.konsumen[index].nama}',
                                  style: TextStyle(
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
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${state.konsumen[index].noTelp}',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Pinjaman: 2 Galon',
                                      style: TextStyle(
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
                                    icon: Icon(
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
