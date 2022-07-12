import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/konsumen/pesanan/pesanan_konsumen_filtered_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class FilterPesananScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBackgroundWhite,
      appBar: AppBar(
        title: Text('Filter'),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FilterPesananKonsumenBloc, FilterPesananKonsumenState>(
              builder: (context, state) {
                if (state is FilterPesananKonsumenLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FilterPesananKonsumenLoaded) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: kJayaTirtaBlue300,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    child: const Text('Terapkan'),
                    onPressed: () {
                      print(state.filteredPesanan);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PesananKonsumenFilteredScreen(
                            daftarPesanan: state.filteredPesanan,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('Something went wrong.');
                }
              },
            ),
          ],
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Status Pesanan',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kJayaTirtaBlack900,
                )),
            BlocBuilder<FilterPesananKonsumenBloc, FilterPesananKonsumenState>(
              builder: (context, state) {
                if (state is FilterPesananKonsumenLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FilterPesananKonsumenLoaded) {
                  return Wrap(
                    children: state.filter.statusFilters
                        .asMap()
                        .entries
                        .map(
                          (status) => InkWell(
                            onTap: () {
                              context.read<FilterPesananKonsumenBloc>().add(
                                    UpdateStatusFilterPesananKonsumen(
                                      statusFilter: state
                                          .filter.statusFilters[status.key]
                                          .copyWith(
                                              value: !state
                                                  .filter
                                                  .statusFilters[status.key]
                                                  .value),
                                    ),
                                  );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                right: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: state
                                        .filter.statusFilters[status.key].value
                                    ? kJayaTirtaBlue100
                                    : const Color.fromARGB(255, 224, 224, 224),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${state.filter.statusFilters[status.key].status}',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
