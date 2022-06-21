import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/produk/produk_bloc.dart';
import 'package:jaya_tirta/presentation/penjual/produk/detail_produk_screen.dart';
import 'package:jaya_tirta/presentation/penjual/produk/tambah_produk_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class ProdukScreen extends StatefulWidget {
  const ProdukScreen({Key? key}) : super(key: key);

  @override
  State<ProdukScreen> createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
              child: Text(
                'Produk Jaya Tirta',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: kJayaTirtaBlack900,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 32.0, right: 32.0, top: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TambahProdukScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Tambah Produk',
                    style: TextStyle(
                        fontFamily: 'Nunito', fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            BlocBuilder<ProdukBloc, ProdukState>(
              builder: (context, state) {
                if (state is ProdukLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProdukLoaded) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.produk.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailProdukScreen(
                                produk: state.produk[index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16.0,
                          child: Column(
                            children: [
                              Image.network(state.produk[index].gambar!),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  state.produk[index].namaProduk!,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  '\Rp. ${state.produk[index].harga}',
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                } else {
                  return Text('Something went wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
