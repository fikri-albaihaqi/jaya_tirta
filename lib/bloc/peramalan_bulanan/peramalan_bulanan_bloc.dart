import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/peramalan/peramalan_repository.dart';

part 'peramalan_bulanan_event.dart';
part 'peramalan_bulanan_state.dart';

class PeramalanBulananBloc
    extends Bloc<PeramalanBulananEvent, PeramalanBulananState> {
  final PeramalanRepository _peramalanRepository;
  StreamSubscription? _peramalanSubscription;

  PeramalanBulananBloc({required PeramalanRepository peramalanRepository})
      : _peramalanRepository = peramalanRepository,
        super(PeramalanBulananLoading()) {
    on<LoadPeramalanBulanan>(_onLoadPeramalan);
    on<LoadedPeramalanBulanan>(_onLoadedPeramalan);
  }

  void _onLoadPeramalan(
    LoadPeramalanBulanan event,
    Emitter<PeramalanBulananState> emit,
  ) {
    _peramalanSubscription?.cancel();
    _peramalanSubscription = _peramalanRepository.getRamalanBulanan().listen(
          (peramalan) => add(
            LoadedPeramalanBulanan(peramalan),
          ),
        );
  }

  void _onLoadedPeramalan(
    LoadedPeramalanBulanan event,
    Emitter<PeramalanBulananState> emit,
  ) {
    emit(PeramalanBulananLoaded(peramalan: event.peramalan));
  }
}
