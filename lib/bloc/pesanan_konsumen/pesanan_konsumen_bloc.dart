import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/pesanan/pesanan_repository.dart';

part 'pesanan_konsumen_event.dart';
part 'pesanan_konsumen_state.dart';

class PesananKonsumenBloc
    extends Bloc<PesananKonsumenEvent, PesananKonsumenState> {
  final PesananRepository _pesananRepository;
  StreamSubscription? _pesananSubscription;

  PesananKonsumenBloc({required PesananRepository pesananRepository})
      : _pesananRepository = pesananRepository,
        super(PesananKonsumenLoading()) {
    on<LoadPesananKonsumen>(_onLoadPesananKonsumen);
    on<LoadedPesananKonsumen>(_onLoadedPesananKonsumen);
  }

  void _onLoadPesananKonsumen(
    LoadPesananKonsumen event,
    Emitter<PesananKonsumenState> emit,
  ) {
    _pesananSubscription?.cancel();
    _pesananSubscription =
        _pesananRepository.getPesananKonsumen(event.idKonsumen!).listen(
              (pesanan) => add(
                LoadedPesananKonsumen(pesanan),
              ),
            );
  }

  void _onLoadedPesananKonsumen(
    LoadedPesananKonsumen event,
    Emitter<PesananKonsumenState> emit,
  ) {
    emit(PesananKonsumenLoaded(pesanan: event.pesanan));
  }
}
