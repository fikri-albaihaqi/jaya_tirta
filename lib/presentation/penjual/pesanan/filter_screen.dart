import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/presentation/penjual/pesanan/pesanan_filtered_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBackgroundWhite,
      appBar: AppBar(
        title: const Text('Filter'),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                if (state is FilterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FilterLoaded) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PesananFilteredScreen(
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
        ),
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
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                if (state is FilterLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FilterLoaded) {
                  return Wrap(
                    children: state.filter.statusFilters
                        .asMap()
                        .entries
                        .map(
                          (status) => InkWell(
                            onTap: () {
                              context.read<FilterBloc>().add(
                                    UpdateStatusFilter(
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
