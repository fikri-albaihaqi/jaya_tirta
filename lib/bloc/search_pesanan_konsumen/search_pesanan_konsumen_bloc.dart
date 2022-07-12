import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';

part 'search_pesanan_konsumen_event.dart';
part 'search_pesanan_konsumen_state.dart';

class SearchPesananKonsumenBloc
    extends Bloc<SearchPesananKonsumenEvent, SearchPesananKonsumenState> {
  final PesananKonsumenBloc _pesananKonsumenBloc;
  StreamSubscription? _pesananSubscription;

  SearchPesananKonsumenBloc({
    required PesananKonsumenBloc pesananKonsumenBloc,
  })  : _pesananKonsumenBloc = pesananKonsumenBloc,
        super(SearchPesananKonsumenLoading()) {
    on<LoadPesananKonsumenSearch>(_onLoadSearch);
    on<SearchPesananKonsumen>(_onSearchProduct);
    on<UpdatePesananKonsumenResults>(_onUpdateResults);
  }

  void _onLoadSearch(
    LoadPesananKonsumenSearch event,
    Emitter<SearchPesananKonsumenState> emit,
  ) {
    emit(const SearchPesananKonsumenLoaded());
  }

  void _onSearchProduct(
    SearchPesananKonsumen event,
    Emitter<SearchPesananKonsumenState> emit,
  ) {
    List<Pesanan> pesanan =
        (_pesananKonsumenBloc.state as PesananKonsumenLoaded).pesanan;

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
      emit(SearchPesananKonsumenLoaded(pesanan: searchResults));
    } else {
      emit(const SearchPesananKonsumenLoaded());
    }
  }

  void _onUpdateResults(
    UpdatePesananKonsumenResults event,
    Emitter<SearchPesananKonsumenState> emit,
  ) {}

  @override
  Future<void> close() async {
    _pesananSubscription?.cancel();
    super.close();
  }
}
