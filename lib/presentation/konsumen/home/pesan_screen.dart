import 'package:flutter/material.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/konsumen/home/konfirmasi_pesanan_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class PesanScreen extends StatefulWidget {
  PesanScreen({Key? key, required this.produk}) : super(key: key);
  Produk produk;

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  int jumlah = 0;

  void _tambahJumlah() {
    setState(() {
      jumlah++;
    });
  }

  void _kurangiJumlah() {
    setState(() {
      jumlah--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue500,
      appBar: AppBar(
        title: Text('Pesan Produk'),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(26.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  'graphics/prima.png',
                  scale: 1.2,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  widget.produk.namaProduk!,
                  style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 36.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'Stok: ${widget.produk.stok!} pcs',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Stok: Rp ${widget.produk.harga!}',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Jumlah Pembelian',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _kurangiJumlah();
                      },
                      icon: Icon(Icons.remove_circle),
                      color: Colors.white,
                      iconSize: 32.0,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      '$jumlah',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    IconButton(
                      onPressed: () {
                        _tambahJumlah();
                      },
                      icon: Icon(Icons.add_circle),
                      color: Colors.white,
                      iconSize: 32.0,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                KonfirmasiPesananScreen(produk: widget.produk),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: const Text(
                        'Beli',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: kJayaTirtaBlue300),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
