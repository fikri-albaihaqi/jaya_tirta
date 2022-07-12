import 'package:flutter/material.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/penjual/pesanan/detail_pesanan_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class PesananFilteredScreen extends StatefulWidget {
  PesananFilteredScreen({Key? key, required this.daftarPesanan})
      : super(key: key);

  List<Pesanan>? daftarPesanan;
  @override
  State<PesananFilteredScreen> createState() => _PesananFilteredScreenState();
}

class _PesananFilteredScreenState extends State<PesananFilteredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Hasil Filter'),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: widget.daftarPesanan!.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPesananScreen(
                      pesanan: widget.daftarPesanan![index],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.daftarPesanan![index].tanggalPembelian}',
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.daftarPesanan![index].status!,
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
                          Image.network(
                            widget.daftarPesanan![index].gambar!,
                            scale: 2.8,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama: ${widget.daftarPesanan![index].namaKonsumen}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'No Telp: ${widget.daftarPesanan![index].noTelp}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Kec/Kel: ${widget.daftarPesanan![index].keckelurahan}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Alamat: ${widget.daftarPesanan![index].alamat}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Produk: ${widget.daftarPesanan![index].namaProduk}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Jumlah: ${widget.daftarPesanan![index].jumlah}',
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
                        'Total Harga: Rp.${widget.daftarPesanan![index].total}',
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
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
