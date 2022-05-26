import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/utils/colors.dart';

class RingkasanScreen extends StatefulWidget {
  const RingkasanScreen({Key? key}) : super(key: key);

  @override
  State<RingkasanScreen> createState() => _RingkasanScreenState();
}

class _RingkasanScreenState extends State<RingkasanScreen> {
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
            Text('Penjualan'),
            Text('Ramalan'),
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
                                title: Text(
                                  '${state.konsumen[index].nama}',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  'Pinjaman: 2 Galon',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text(
                                                    'Hapus data konsumen'),
                                                content: Text(
                                                    'Apakah anada yakin akan menghapus data konsumen ${state.konsumen[index].nama}?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'Batal'),
                                                      child:
                                                          const Text('Batal')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Hapus');
                                                        context
                                                            .read<
                                                                CrudKonsumenBloc>()
                                                            .add(
                                                              DeleteKonsumen(
                                                                  id: state
                                                                      .konsumen[
                                                                          index]
                                                                      .id!),
                                                            );
                                                      },
                                                      child: const Text(
                                                        'Hapus',
                                                        style: TextStyle(
                                                            color:
                                                                kJayaTirtaErrorRed),
                                                      )),
                                                ],
                                              ));
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
