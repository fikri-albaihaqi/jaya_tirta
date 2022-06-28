import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/penjualan_bulanan/penjualan_bulanan_repository.dart';

part 'penjualan_bulanan_event.dart';
part 'penjualan_bulanan_state.dart';

class PenjualanBulananBloc
    extends Bloc<PenjualanBulananEvent, PenjualanBulananState> {
  final PenjualanBulananRepository _penjualanBulananRepository;
  StreamSubscription? _penjualanBulananSubscription;

  PenjualanBulananBloc(
      {required PenjualanBulananRepository penjualanBulananRepository})
      : _penjualanBulananRepository = penjualanBulananRepository,
        super(PenjualanBulananLoading()) {
    // on<LoadAllPenjualanBulanan>(_onLoadAllPenjualanBulanan);
    on<LoadPenjualanBulanan>(_onLoadPenjualanBulanan);
    on<LoadedPenjualanBulanan>(_onLoadedPenjualanBulanan);
  }

  // void _onLoadAllPenjualanBulanan(
  //   LoadAllPenjualanBulanan event,
  //   Emitter<PenjualanBulananState> emit,
  // ) {
  //   _penjualanBulananSubscription?.cancel();
  //   _penjualanBulananSubscription = _penjualanBulananRepository.getAllPenjualanBulanan().listen(
  //         (penjualanBulanan) => add(
  //           LoadedPenjualanBulanan(penjualanBulanan),
  //         ),
  //       );
  // }

  void _onLoadPenjualanBulanan(
    LoadPenjualanBulanan event,
    Emitter<PenjualanBulananState> emit,
  ) {
    _penjualanBulananSubscription?.cancel();
    _penjualanBulananSubscription =
        _penjualanBulananRepository.getPenjualanBulananTerakhir().listen(
              (penjualanBulanan) => add(
                LoadedPenjualanBulanan(penjualanBulanan),
              ),
            );
  }

  void _onLoadedPenjualanBulanan(
    LoadedPenjualanBulanan event,
    Emitter<PenjualanBulananState> emit,
  ) {
    emit(PenjualanBulananLoaded(penjualanBulanan: event.penjualanBulanan));
  }
}
