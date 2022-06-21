import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/penjual/penjual_repository.dart';

part 'crud_penjual_event.dart';
part 'crud_penjual_state.dart';

class CrudPenjualBloc extends Bloc<CrudPenjualEvent, CrudPenjualState> {
  final PenjualRepository _penjualRepository;
  StreamSubscription? _crudPenjualSubscription;

  CrudPenjualBloc({
    required PenjualRepository penjualRepository,
  })  : _penjualRepository = penjualRepository,
        super(CrudPenjualLoaded()) {
    on<AddPenjual>(_onAddPenjual);
    on<ConfirmAddPenjual>(_onConfirmAddPenjual);
    on<DeletePenjual>(_onDeletePenjual);
    on<UpdatePenjual>(_onUpdatePenjual);
    on<ConfirmUpdatePenjual>(_onConfirmUpdatePenjual);
  }

  void _onAddPenjual(
    AddPenjual event,
    Emitter<CrudPenjualState> emit,
  ) {
    if (this.state is CrudPenjualLoaded) {
      final state = this.state as CrudPenjualLoaded;
      emit(
        CrudPenjualLoaded(
          id: event.id ?? state.id,
          nama: event.nama ?? state.nama,
          noTelp: event.noTelp ?? state.noTelp,
        ),
      );
    }
  }

  void _onConfirmAddPenjual(
    ConfirmAddPenjual event,
    Emitter<CrudPenjualState> emit,
  ) async {
    _crudPenjualSubscription?.cancel();
    if (this.state is CrudPenjualLoaded) {
      try {
        await _penjualRepository.addPenjual(event.penjual);
        emit(CrudPenjualLoaded());
      } catch (_) {}
    }
  }

  void _onDeletePenjual(
    DeletePenjual event,
    Emitter<CrudPenjualState> emit,
  ) async {
    _crudPenjualSubscription?.cancel();
    if (this.state is CrudPenjualLoaded) {
      try {
        await _penjualRepository.deletePenjual(event.id);
        emit(CrudPenjualLoaded());
      } catch (_) {}
    }
  }

  void _onUpdatePenjual(
    UpdatePenjual event,
    Emitter<CrudPenjualState> emit,
  ) {
    if (this.state is CrudPenjualLoaded) {
      final state = this.state as CrudPenjualLoaded;
      emit(
        CrudPenjualLoaded(
          id: event.id ?? state.id,
          nama: event.nama ?? state.nama,
          noTelp: event.noTelp ?? state.noTelp,
        ),
      );
    }
  }

  void _onConfirmUpdatePenjual(
    ConfirmUpdatePenjual event,
    Emitter<CrudPenjualState> emit,
  ) async {
    _crudPenjualSubscription?.cancel();
    if (this.state is CrudPenjualLoaded) {
      try {
        await _penjualRepository.updatePenjual(event.penjual, event.id!);
        emit(CrudPenjualLoaded());
      } catch (_) {}
    }
  }
}
