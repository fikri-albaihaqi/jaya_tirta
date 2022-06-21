import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/peramalan/peramalan_repository.dart';

part 'peramalan_mingguan_event.dart';
part 'peramalan_mingguan_state.dart';

class PeramalanMingguanBloc
    extends Bloc<PeramalanMingguanEvent, PeramalanMingguanState> {
  final PeramalanRepository _peramalanRepository;
  StreamSubscription? _peramalanSubscription;

  PeramalanMingguanBloc({required PeramalanRepository peramalanRepository})
      : _peramalanRepository = peramalanRepository,
        super(PeramalanMingguanLoading()) {
    on<LoadPeramalanMingguan>(_onLoadPeramalan);
    on<LoadedPeramalanMingguan>(_onLoadedPeramalan);
  }

  void _onLoadPeramalan(
    LoadPeramalanMingguan event,
    Emitter<PeramalanMingguanState> emit,
  ) {
    _peramalanSubscription?.cancel();
    _peramalanSubscription = _peramalanRepository.getRamalanMingguan().listen(
          (peramalan) => add(
            LoadedPeramalanMingguan(peramalan),
          ),
        );
  }

  void _onLoadedPeramalan(
    LoadedPeramalanMingguan event,
    Emitter<PeramalanMingguanState> emit,
  ) {
    emit(PeramalanMingguanLoaded(peramalan: event.peramalan));
  }
}
