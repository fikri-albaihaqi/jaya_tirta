import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/repositories/produk/produk_repository.dart';

import '../../data/models/models.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final ProdukRepository _produkRepository;
  StreamSubscription? _produkSubscription;

  ProdukBloc({required ProdukRepository produkRepository})
      : _produkRepository = produkRepository,
        super(ProdukLoading()) {
    on<LoadProduk>(_onLoadProduk);
    on<LoadedProduk>(_onLoadedProduk);
  }

  void _onLoadProduk(
    LoadProduk event,
    Emitter<ProdukState> emit,
  ) {
    _produkSubscription?.cancel();
    _produkSubscription = _produkRepository.getAllProduk().listen(
          (produk) => add(
            LoadedProduk(produk),
          ),
        );
  }

  void _onLoadedProduk(
    LoadedProduk event,
    Emitter<ProdukState> emit,
  ) {
    emit(ProdukLoaded(produk: event.produk));
  }
}
