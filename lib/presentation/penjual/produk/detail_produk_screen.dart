import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/penjual/produk/edit_produk.dart';
import 'package:jaya_tirta/presentation/penjual/produk/produk_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

import '../../../bloc/blocs.dart';

class DetailProdukScreen extends StatefulWidget {
  DetailProdukScreen({Key? key, required this.produk}) : super(key: key);
  Produk produk;

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      appBar: AppBar(
        backgroundColor: kJayaTirtaBlue500,
        title: const Text('Detail Produk'),
      ),
      body: BlocBuilder<CrudProdukBloc, CrudProdukState>(
        builder: (context, state) {
          if (state is CrudProdukLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CrudProdukLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            widget.produk.namaProduk!,
                            style: const TextStyle(
                                fontFamily: 'Kanit', fontSize: 36.0),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Image.network(widget.produk.gambar!),
                        const SizedBox(height: 16.0),
                        Text(
                          'Stok: ${widget.produk.stok!}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          'Harga: ${widget.produk.harga!}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CrudProdukBloc>().add(
                                  DeleteProduk(id: widget.produk.id!),
                                );
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProdukScreen(
                                  produk: widget.produk,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
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
