import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/konsumen.dart';
import 'package:jaya_tirta/data/repositories/konsumen/konsumen_repository.dart';

part 'konsumen_event.dart';
part 'konsumen_state.dart';

class KonsumenBloc extends Bloc<KonsumenEvent, KonsumenState> {
  final KonsumenRepository _konsumenRepository;
  StreamSubscription? _konsumenSubscription;

  KonsumenBloc({required KonsumenRepository konsumenRepository})
      : _konsumenRepository = konsumenRepository,
        super(KonsumenLoading()) {
    on<LoadKonsumen>(_onLoadKonsumen);
    on<LoadedKonsumen>(_onLoadedKonsumen);
  }

  void _onLoadKonsumen(
    LoadKonsumen event,
    Emitter<KonsumenState> emit,
  ) {
    _konsumenSubscription?.cancel();
    _konsumenSubscription = _konsumenRepository.getAllKonsumen().listen(
          (konsumen) => add(
            LoadedKonsumen(konsumen),
          ),
        );
  }

  void _onLoadedKonsumen(
    LoadedKonsumen event,
    Emitter<KonsumenState> emit,
  ) {
    emit(KonsumenLoaded(konsumen: event.konsumen));
  }
}
