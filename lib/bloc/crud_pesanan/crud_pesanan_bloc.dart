import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/pesanan/pesanan_repository.dart';

part 'crud_pesanan_event.dart';
part 'crud_pesanan_state.dart';

class CrudPesananBloc extends Bloc<CrudPesananEvent, CrudPesananState> {
  final PesananRepository _pesananRepository;
  StreamSubscription? _crudPesananSubscription;

  CrudPesananBloc({
    required PesananRepository pesananRepository,
  })  : _pesananRepository = pesananRepository,
        super(CrudPesananLoaded()) {
    on<AddPesanan>(_onAddPesanan);
    on<ConfirmAddPesanan>(_onConfirmAddPesanan);
    on<DeletePesanan>(_onDeletePesanan);
    on<UpdatePesanan>(_onUpdatePesanan);
    on<ConfirmUpdatePesanan>(_onConfirmUpdatePesanan);
  }

  void _onAddPesanan(
    AddPesanan event,
    Emitter<CrudPesananState> emit,
  ) {
    if (this.state is CrudPesananLoaded) {
      final state = this.state as CrudPesananLoaded;
      emit(
        CrudPesananLoaded(
          status: event.status ?? state.status,
          jumlah: event.jumlah ?? state.jumlah,
          total: event.total ?? state.total,
          idProduk: event.idProduk ?? state.idProduk,
          namaProduk: event.namaProduk ?? state.namaProduk,
          gambar: event.gambar ?? state.gambar,
          harga: event.harga ?? state.harga,
          stok: event.stok ?? state.stok,
          idKonsumen: event.idKonsumen ?? state.idKonsumen,
          namaKonsumen: event.namaKonsumen ?? state.namaKonsumen,
          alamat: event.alamat ?? state.alamat,
          noTelp: event.noTelp ?? state.noTelp,
        ),
      );
    }
  }

  void _onConfirmAddPesanan(
    ConfirmAddPesanan event,
    Emitter<CrudPesananState> emit,
  ) {
    _crudPesananSubscription?.cancel();
    if (this.state is CrudPesananLoaded) {
      final state = this.state as CrudPesananLoaded;
      try {
        _pesananRepository.addPesanan(state.pesanan);
        emit(CrudPesananLoaded());
      } catch (_) {}
    }
  }

  void _onDeletePesanan(
    DeletePesanan event,
    Emitter<CrudPesananState> emit,
  ) async {
    _crudPesananSubscription?.cancel();
    if (this.state is CrudPesananLoaded) {
      try {
        await _pesananRepository.deletePesanan(event.id);
        emit(CrudPesananLoaded());
      } catch (_) {}
    }
  }

  void _onUpdatePesanan(
    UpdatePesanan event,
    Emitter<CrudPesananState> emit,
  ) {
    if (this.state is CrudPesananLoaded) {
      final state = this.state as CrudPesananLoaded;
      emit(
        CrudPesananLoaded(
          id: event.id ?? state.id,
          status: event.status ?? state.status,
          jumlah: event.jumlah ?? state.jumlah,
          total: event.total ?? state.total,
          idProduk: event.idProduk ?? state.idProduk,
          namaProduk: event.namaProduk ?? state.namaProduk,
          gambar: event.gambar ?? state.gambar,
          harga: event.harga ?? state.harga,
          stok: event.stok ?? state.stok,
          idKonsumen: event.idKonsumen ?? state.idKonsumen,
          namaKonsumen: event.namaKonsumen ?? state.namaKonsumen,
          alamat: event.alamat ?? state.alamat,
          noTelp: event.noTelp ?? state.noTelp,
        ),
      );
    }
  }

  void _onConfirmUpdatePesanan(
    ConfirmUpdatePesanan event,
    Emitter<CrudPesananState> emit,
  ) async {
    _crudPesananSubscription?.cancel();
    if (this.state is CrudPesananLoaded) {
      final state = this.state as CrudPesananLoaded;
      try {
        _pesananRepository.updatePesanan(state.pesanan, event.id!);
        emit(CrudPesananLoaded());
      } catch (_) {}
    }
  }
}
