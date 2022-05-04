import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/konsumen.dart';
import 'package:jaya_tirta/data/repositories/konsumen/konsumen_repository.dart';

part 'crud_pesanan_event.dart';
part 'crud_pesanan_state.dart';

class CrudPesananBloc extends Bloc<CrudPesananEvent, CrudPesananState> {
  final KonsumenRepository _konsumenRepository;
  StreamSubscription? _konsumenSubscription;

  CrudPesananBloc({required KonsumenRepository konsumenRepository})
      : _konsumenRepository = konsumenRepository,
        super(CrudPesananLoaded()) {
    on<LoadCrudPesanan>(_onLoadKonsumen);
    on<LoadedCrudPesanan>(_onLoadedKonsumen);
  }

  void _onLoadKonsumen(
    LoadCrudPesanan event,
    Emitter<CrudPesananState> emit,
  ) {
    _konsumenSubscription?.cancel();
    _konsumenSubscription = _konsumenRepository.getAllKonsumen().listen(
          (konsumen) => add(
            LoadedCrudPesanan(konsumen),
          ),
        );
  }

  void _onLoadedKonsumen(
    LoadedCrudPesanan event,
    Emitter<CrudPesananState> emit,
  ) {
    emit(CrudPesananLoaded(konsumen: event.konsumen));
  }
}
