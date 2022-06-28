import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/pesan/pesan_repository.dart';

part 'pesan_receiver_event.dart';
part 'pesan_receiver_state.dart';

class PesanReceiverBloc extends Bloc<PesanReceiverEvent, PesanReceiverState> {
  final PesanRepository _pesanRepository;
  late final StreamSubscription? pesanStream;

  PesanReceiverBloc({
    required PesanRepository pesanRepository,
  })  : _pesanRepository = pesanRepository,
        super(PesanReceiverInitial()) {
    on<PesanRequested>(_onPesanRequestedToState);
    on<PesanReceived>(_onPesanReceivedToState);
  }

  @override
  Future<void> close() {
    pesanStream?.cancel();
    return super.close();
  }

  FutureOr<void> _onPesanRequestedToState(
    PesanRequested event,
    Emitter<PesanReceiverState> emit,
  ) {
    try {
      emit(PesanLoadInprogress());
      pesanStream = _pesanRepository
          .getPesans(obrolanId: event.obrolanId)
          .listen((pesans) {
        add(PesanReceived(pesans: pesans));
      });
    } on Exception catch (e, trace) {
      log('Issue while loading Pesan $e $trace');
      emit(PesanLoadFailure(pesan: e.toString()));
    }
  }

  FutureOr<void> _onPesanReceivedToState(
    PesanReceived event,
    Emitter<PesanReceiverState> emit,
  ) {
    emit(PesanLoadSuccess(pesans: event.pesans));
  }
}
