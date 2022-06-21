import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/penjual/penjual_repository.dart';

part 'penjual_event.dart';
part 'penjual_state.dart';

class PenjualBloc extends Bloc<PenjualEvent, PenjualState> {
  final PenjualRepository _penjualRepository;
  StreamSubscription? _penjualSubscription;

  PenjualBloc({required PenjualRepository penjualRepository})
      : _penjualRepository = penjualRepository,
        super(PenjualLoading()) {
    on<LoadAllPenjual>(_onLoadAllPenjual);
    on<LoadPenjual>(_onLoadPenjual);
    on<LoadedPenjual>(_onLoadedPenjual);
  }

  void _onLoadAllPenjual(
    LoadAllPenjual event,
    Emitter<PenjualState> emit,
  ) {
    _penjualSubscription?.cancel();
    _penjualSubscription = _penjualRepository.getAllPenjual().listen(
          (penjual) => add(
            LoadedPenjual(penjual),
          ),
        );
  }

  void _onLoadPenjual(
    LoadPenjual event,
    Emitter<PenjualState> emit,
  ) {
    _penjualSubscription?.cancel();
    _penjualSubscription = _penjualRepository.getProfil(event.id!).listen(
          (penjual) => add(
            LoadedPenjual(penjual),
          ),
        );
  }

  void _onLoadedPenjual(
    LoadedPenjual event,
    Emitter<PenjualState> emit,
  ) {
    emit(PenjualLoaded(penjual: event.penjual));
  }
}
