import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/konsumen.dart';
import 'package:jaya_tirta/data/repositories/konsumen/konsumen_repository.dart';

part 'crud_konsumen_event.dart';
part 'crud_konsumen_state.dart';

class CrudKonsumenBloc extends Bloc<CrudKonsumenEvent, CrudKonsumenState> {
  final KonsumenRepository _konsumenRepository;
  StreamSubscription? _crudKonsumenSubscription;

  CrudKonsumenBloc({
    required KonsumenRepository konsumenRepository,
  })  : _konsumenRepository = konsumenRepository,
        super(CrudKonsumenLoaded()) {
    on<AddKonsumen>(_onAddKonsumen);
    on<ConfirmAddKonsumen>(_onConfirmAddKonsumen);
    on<DeleteKonsumen>(_onDeleteKonsumen);
    on<UpdateKonsumen>(_onUpdateKonsumen);
    on<ConfirmUpdateKonsumen>(_onConfirmUpdateKonsumen);
  }

  void _onAddKonsumen(
    AddKonsumen event,
    Emitter<CrudKonsumenState> emit,
  ) {
    if (this.state is CrudKonsumenLoaded) {
      final state = this.state as CrudKonsumenLoaded;
      emit(
        CrudKonsumenLoaded(
          nama: event.nama ?? state.nama,
          alamat: event.alamat ?? state.alamat,
          noTelp: event.noTelp ?? state.noTelp,
        ),
      );
    }
  }

  void _onConfirmAddKonsumen(
    ConfirmAddKonsumen event,
    Emitter<CrudKonsumenState> emit,
  ) async {
    _crudKonsumenSubscription?.cancel();
    if (this.state is CrudKonsumenLoaded) {
      try {
        await _konsumenRepository.addKonsumen(event.konsumen);
        print('done');
        emit(CrudKonsumenLoaded());
      } catch (_) {}
    }
  }

  void _onDeleteKonsumen(
    DeleteKonsumen event,
    Emitter<CrudKonsumenState> emit,
  ) async {
    _crudKonsumenSubscription?.cancel();
    if (this.state is CrudKonsumenLoaded) {
      try {
        await _konsumenRepository.deleteKonsumen(event.id);
        print('done');
        emit(CrudKonsumenLoaded());
      } catch (_) {}
    }
  }

  void _onUpdateKonsumen(
    UpdateKonsumen event,
    Emitter<CrudKonsumenState> emit,
  ) {
    if (this.state is CrudKonsumenLoaded) {
      final state = this.state as CrudKonsumenLoaded;
      emit(
        CrudKonsumenLoaded(
          nama: event.nama ?? state.nama,
          alamat: event.alamat ?? state.alamat,
          noTelp: event.noTelp ?? state.noTelp,
        ),
      );
    }
  }

  void _onConfirmUpdateKonsumen(
    ConfirmUpdateKonsumen event,
    Emitter<CrudKonsumenState> emit,
  ) async {
    _crudKonsumenSubscription?.cancel();
    if (this.state is CrudKonsumenLoaded) {
      try {
        await _konsumenRepository.updateKonsumen(event.konsumen, event.id!);
        print('done');
        emit(CrudKonsumenLoaded());
      } catch (_) {}
    }
  }
}
