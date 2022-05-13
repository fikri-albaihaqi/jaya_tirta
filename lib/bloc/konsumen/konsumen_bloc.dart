import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/repositories/konsumen/konsumen_repository.dart';
import 'package:jaya_tirta/data/models/models.dart';

part 'konsumen_event.dart';
part 'konsumen_state.dart';

class KonsumenBloc extends Bloc<KonsumenEvent, KonsumenState> {
  final KonsumenRepository _konsumenRepository;
  StreamSubscription? _konsumenSubscription;

  KonsumenBloc({required KonsumenRepository konsumenRepository})
      : _konsumenRepository = konsumenRepository,
        super(KonsumenLoading()) {
    on<LoadAllKonsumen>(_onLoadAllKonsumen);
    on<LoadKonsumen>(_onLoadKonsumen);
    on<LoadedKonsumen>(_onLoadedKonsumen);
  }

  void _onLoadAllKonsumen(
    LoadAllKonsumen event,
    Emitter<KonsumenState> emit,
  ) {
    _konsumenSubscription?.cancel();
    _konsumenSubscription = _konsumenRepository.getAllKonsumen().listen(
          (konsumen) => add(
            LoadedKonsumen(konsumen),
          ),
        );
  }

  void _onLoadKonsumen(
    LoadKonsumen event,
    Emitter<KonsumenState> emit,
  ) {
    KonsumenLoaded(konsumen: _konsumenRepository.getKonsumenPesan(event.id!));
  }

  void _onLoadedKonsumen(
    LoadedKonsumen event,
    Emitter<KonsumenState> emit,
  ) {
    emit(KonsumenLoaded(konsumen: event.konsumen));
  }
}
