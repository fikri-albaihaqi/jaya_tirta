import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/peramalan/peramalan_repository.dart';

part 'peramalan_event.dart';
part 'peramalan_state.dart';

class PeramalanBloc extends Bloc<PeramalanEvent, PeramalanState> {
  final PeramalanRepository _peramalanRepository;
  StreamSubscription? _peramalanSubscription;

  PeramalanBloc({required PeramalanRepository peramalanRepository})
      : _peramalanRepository = peramalanRepository,
        super(PeramalanLoading()) {
    on<LoadPeramalan>(_onLoadPeramalan);
    on<LoadedPeramalan>(_onLoadedPeramalan);
  }

  void _onLoadPeramalan(
    LoadPeramalan event,
    Emitter<PeramalanState> emit,
  ) {
    _peramalanSubscription?.cancel();
    _peramalanSubscription = _peramalanRepository.getRamalanBulanan().listen(
          (peramalan) => add(
            LoadedPeramalan(peramalan),
          ),
        );
  }

  void _onLoadedPeramalan(
    LoadedPeramalan event,
    Emitter<PeramalanState> emit,
  ) {
    print(event.peramalan);
    emit(PeramalanLoaded(peramalan: event.peramalan));
  }
}
