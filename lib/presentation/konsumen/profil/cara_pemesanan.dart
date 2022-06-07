import 'package:flutter/material.dart';
import 'package:jaya_tirta/utils/colors.dart';

class CaraPemesananScreen extends StatefulWidget {
  const CaraPemesananScreen({Key? key}) : super(key: key);

  @override
  State<CaraPemesananScreen> createState() => _CaraPemesananScreenState();
}

class _CaraPemesananScreenState extends State<CaraPemesananScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      appBar: AppBar(
        backgroundColor: kJayaTirtaBlue500,
        title: const Text('Cara Pemesanan'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Cara Memesan Air Mineral Kemasan Galon',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '1. Pilih merk air mineral kemasan galon yang akan dibeli',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      Text(
                        '2. Tentukan jumlah produk yang akan dibeli.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      Text(
                        '3. Tekan tombol “Beli”.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      Text(
                        '4. Isi data diri pada form yang tersedia.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      Text(
                        '5. Tekan tombol “Simpan”.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      Text(
                        '6. Pastikan jumlah produk dan data diri yang diisi sudah benar. Jika sudah tekan tombol “Konfirmasi Pesanan”.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      Text(
                        '7. Pesanan berhasil dibuat dan akan segera diproses.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
