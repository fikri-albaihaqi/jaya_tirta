import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/penjualan_bulanan/penjualan_bulanan_repository.dart';

part 'crud_penjualan_bulanan_event.dart';
part 'crud_penjualan_bulanan_state.dart';

class CrudPenjualanBulananBloc
    extends Bloc<CrudPenjualanBulananEvent, CrudPenjualanBulananState> {
  final PenjualanBulananRepository _penjualanBulananRepository;
  StreamSubscription? _crudPenjualanBulananSubscription;

  CrudPenjualanBulananBloc({
    required PenjualanBulananRepository penjualanBulananRepository,
  })  : _penjualanBulananRepository = penjualanBulananRepository,
        super(CrudPenjualanBulananLoaded()) {
    on<AddPenjualanBulanan>(_onAddPenjualanBulanan);
    on<ConfirmAddPenjualanBulanan>(_onConfirmAddPenjualanBulanan);
    on<DeletePenjualanBulanan>(_onDeletePenjualanBulanan);
    on<UpdatePenjualanBulanan>(_onUpdatePenjualanBulanan);
    on<UpdateJumlahPenjualan>(_onUpdateJumlahPenjualan);
  }

  void _onAddPenjualanBulanan(
    AddPenjualanBulanan event,
    Emitter<CrudPenjualanBulananState> emit,
  ) {
    if (this.state is CrudPenjualanBulananLoaded) {
      final state = this.state as CrudPenjualanBulananLoaded;
      emit(
        CrudPenjualanBulananLoaded(
          id: event.id ?? state.id,
          tanggal: event.tanggal ?? state.tanggal,
          jumlahPenjualan: event.jumlahPenjualan ?? state.jumlahPenjualan,
        ),
      );
    }
  }

  void _onConfirmAddPenjualanBulanan(
    ConfirmAddPenjualanBulanan event,
    Emitter<CrudPenjualanBulananState> emit,
  ) async {
    _crudPenjualanBulananSubscription?.cancel();
    if (this.state is CrudPenjualanBulananLoaded) {
      final state = this.state as CrudPenjualanBulananLoaded;
      try {
        await _penjualanBulananRepository
            .addPenjualanBulanan(state.penjualanBulanan!);
        emit(CrudPenjualanBulananLoaded());
      } catch (_) {}
    }
  }

  void _onDeletePenjualanBulanan(
    DeletePenjualanBulanan event,
    Emitter<CrudPenjualanBulananState> emit,
  ) async {
    _crudPenjualanBulananSubscription?.cancel();
    if (this.state is CrudPenjualanBulananLoaded) {
      try {
        await _penjualanBulananRepository.deletePenjualanBulanan(event.id);
        emit(CrudPenjualanBulananLoaded());
      } catch (_) {}
    }
  }

  void _onUpdatePenjualanBulanan(
    UpdatePenjualanBulanan event,
    Emitter<CrudPenjualanBulananState> emit,
  ) {
    if (this.state is CrudPenjualanBulananLoaded) {
      final state = this.state as CrudPenjualanBulananLoaded;
      emit(
        CrudPenjualanBulananLoaded(
            id: event.id ?? state.id,
            tanggal: event.tanggal ?? state.tanggal,
            jumlahPenjualan: event.jumlahPenjualan ?? state.jumlahPenjualan),
      );
    }
  }

  void _onUpdateJumlahPenjualan(
    UpdateJumlahPenjualan event,
    Emitter<CrudPenjualanBulananState> emit,
  ) async {
    _crudPenjualanBulananSubscription?.cancel();
    if (this.state is CrudPenjualanBulananLoaded) {
      try {
        await _penjualanBulananRepository.updateJumlahPenjualan(
            event.id!, event.jumlahPenjualan!);
        emit(CrudPenjualanBulananLoaded());
      } catch (_) {}
    }
  }
}
