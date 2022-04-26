import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/produk.dart';
import 'package:jaya_tirta/data/repositories/produk/produk_repository.dart';

part 'crud_produk_event.dart';
part 'crud_produk_state.dart';

class CrudProdukBloc extends Bloc<CrudProdukEvent, CrudProdukState> {
  final ProdukRepository _produkRepository;
  StreamSubscription? _crudProdukSubscription;

  CrudProdukBloc({
    required ProdukRepository produkRepository,
  })  : _produkRepository = produkRepository,
        super(CrudProdukLoaded()) {
    on<AddProduk>(_onAddProduk);
    on<ConfirmAddProduk>(_onConfirmAddProduk);
    on<DeleteProduk>(_onDeleteProduk);
    on<UpdateProduk>(_onUpdateProduk);
    on<ConfirmUpdateProduk>(_onConfirmUpdateProduk);
  }

  void _onAddProduk(
    AddProduk event,
    Emitter<CrudProdukState> emit,
  ) {
    if (this.state is CrudProdukLoaded) {
      final state = this.state as CrudProdukLoaded;
      emit(
        CrudProdukLoaded(
          namaProduk: event.namaProduk ?? state.namaProduk,
          gambar: event.gambar ?? state.gambar,
          harga: event.harga ?? state.harga,
          stok: event.stok ?? state.stok,
        ),
      );
    }
  }

  void _onConfirmAddProduk(
    ConfirmAddProduk event,
    Emitter<CrudProdukState> emit,
  ) async {
    _crudProdukSubscription?.cancel();
    if (this.state is CrudProdukLoaded) {
      try {
        await _produkRepository.addProduk(event.produk);
        print('done');
        emit(CrudProdukLoaded());
      } catch (_) {}
    }
  }

  void _onDeleteProduk(
    DeleteProduk event,
    Emitter<CrudProdukState> emit,
  ) async {
    _crudProdukSubscription?.cancel();
    if (this.state is CrudProdukLoaded) {
      try {
        await _produkRepository.deleteProduk(event.id);
        print('done');
        emit(CrudProdukLoaded());
      } catch (_) {}
    }
  }

  void _onUpdateProduk(
    UpdateProduk event,
    Emitter<CrudProdukState> emit,
  ) {
    if (this.state is CrudProdukLoaded) {
      final state = this.state as CrudProdukLoaded;
      emit(
        CrudProdukLoaded(
          namaProduk: event.namaProduk ?? state.namaProduk,
          gambar: event.gambar ?? state.gambar,
          harga: event.harga ?? state.harga,
          stok: event.stok ?? state.stok,
        ),
      );
    }
  }

  void _onConfirmUpdateProduk(
    ConfirmUpdateProduk event,
    Emitter<CrudProdukState> emit,
  ) async {
    _crudProdukSubscription?.cancel();
    if (this.state is CrudProdukLoaded) {
      try {
        await _produkRepository.updateProduk(event.produk, event.id!);
        print('done');
        emit(CrudProdukLoaded());
      } catch (_) {}
    }
  }
}
