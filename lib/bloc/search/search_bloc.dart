import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PesananBloc _pesananBloc;
  StreamSubscription? _pesananSubscription;

  SearchBloc({
    required PesananBloc pesananBloc,
  })  : _pesananBloc = pesananBloc,
        super(SearchLoading()) {
    on<LoadSearch>(_onLoadSearch);
    on<SearchPesanan>(_onSearchProduct);
    on<UpdateResults>(_onUpdateResults);
  }

  void _onLoadSearch(
    LoadSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchLoaded());
  }

  void _onSearchProduct(
    SearchPesanan event,
    Emitter<SearchState> emit,
  ) {
    List<Pesanan> pesanan = (_pesananBloc.state as PesananLoaded).pesanan;

    if (event.parameter!.isNotEmpty) {
      List<Pesanan> searchResults = pesanan.where((pesanan) {
        return pesanan.status!
                .toLowerCase()
                .contains(event.parameter!.toLowerCase()) ||
            pesanan.tanggalPembelian!
                .toLowerCase()
                .contains(event.parameter!.toLowerCase()) ||
            pesanan.namaKonsumen!
                .toLowerCase()
                .contains(event.parameter!.toLowerCase()) ||
            pesanan.keckelurahan!
                .toLowerCase()
                .contains(event.parameter!.toLowerCase()) ||
            pesanan.alamat!
                .toLowerCase()
                .contains(event.parameter!.toLowerCase()) ||
            pesanan.namaProduk!
                .toLowerCase()
                .contains(event.parameter!.toLowerCase());
      }).toList();
      emit(SearchLoaded(pesanan: searchResults));
    } else {
      emit(SearchLoaded());
    }
  }

  void _onUpdateResults(
    UpdateResults event,
    Emitter<SearchState> emit,
  ) {}

  @override
  Future<void> close() async {
    _pesananSubscription?.cancel();
    super.close();
  }
}
