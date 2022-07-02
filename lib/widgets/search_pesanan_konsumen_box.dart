import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/konsumen/pesanan/detail_pesanan_konsumen.dart';
import 'package:jaya_tirta/presentation/konsumen/pesanan/filter_pesanan_screen.dart';
import 'package:jaya_tirta/presentation/penjual/pesanan/detail_pesanan_screen.dart';
import 'package:jaya_tirta/presentation/penjual/pesanan/filter_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class SearchPesananKonsumenBox extends StatelessWidget {
  const SearchPesananKonsumenBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchTextController = TextEditingController();

    return BlocBuilder<SearchPesananKonsumenBloc, SearchPesananKonsumenState>(
      builder: (context, state) {
        if (state is SearchPesananKonsumenLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is SearchPesananKonsumenLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchTextController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Cari Pesanan',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.all(10),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<SearchPesananKonsumenBloc>().add(
                              SearchPesananKonsumen(
                                parameter: value,
                              ),
                            );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterPesananScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Nunito',
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.tune,
                        color: kJayaTirtaBlack900,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: kJayaTirtaBlack900,
                    ),
                  ),
                ),
              ),
              Builder(builder: (context) {
                if (state.pesanan.isNotEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Hasil Pencarian',
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 20,
                          color: kJayaTirtaBlack900,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.pesanan.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPesananKonsumenScreen(
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
                                              state.pesanan[index]
                                                  .tanggalPembelian!,
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
                                                  '${state.pesanan[index].namaProduk}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${state.pesanan[index].jumlah} galon',
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Harga: Rp.${state.pesanan[index].total}',
                                              style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text(
                                              'Lihat Detail',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                } else if (_searchTextController.text.isNotEmpty) {
                  return Column(
                    children: const [
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Text(
                        'Pesanan tidak ditemukan!',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                } else if (_searchTextController.text.isEmpty) {
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              }),
            ],
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}
