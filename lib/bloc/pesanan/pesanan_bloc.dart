import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/pesanan/pesanan_repository.dart';

part 'pesanan_event.dart';
part 'pesanan_state.dart';

class PesananBloc extends Bloc<PesananEvent, PesananState> {
  final PesananRepository _pesananRepository;
  StreamSubscription? _pesananSubscription;

  PesananBloc({required PesananRepository pesananRepository})
      : _pesananRepository = pesananRepository,
        super(PesananLoading()) {
    on<LoadPesanan>(_onLoadPesanan);
    on<LoadedPesanan>(_onLoadedPesanan);
    on<LoadRiwayatPesanan>(_onLoadRiwayatPesanan);
    on<LoadedRiwayatPesanan>(_onLoadedRiwayatPesanan);
  }

  void _onLoadPesanan(
    LoadPesanan event,
    Emitter<PesananState> emit,
  ) {
    _pesananSubscription?.cancel();
    _pesananSubscription = _pesananRepository.getAllPesanan().listen(
          (pesanan) => add(
            LoadedPesanan(pesanan),
          ),
        );
  }

  void _onLoadedPesanan(
    LoadedPesanan event,
    Emitter<PesananState> emit,
  ) {
    emit(PesananLoaded(pesanan: event.pesanan));
  }

  void _onLoadRiwayatPesanan(
    LoadRiwayatPesanan event,
    Emitter<PesananState> emit,
  ) {
    _pesananSubscription?.cancel();
    _pesananSubscription = _pesananRepository.getRiwayatPesanan().listen(
          (pesanan) => add(
            LoadedRiwayatPesanan(pesanan),
          ),
        );
  }

  void _onLoadedRiwayatPesanan(
    LoadedRiwayatPesanan event,
    Emitter<PesananState> emit,
  ) {
    emit(PesananLoaded(pesanan: event.pesanan));
  }
}
