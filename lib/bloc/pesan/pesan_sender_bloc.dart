import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/pesan/pesan_repository.dart';

part 'pesan_sender_event.dart';
part 'pesan_sender_state.dart';

class PesanSenderBloc extends Bloc<PesanSenderEvent, PesanSenderState> {
  final PesanRepository _pesanRepository;

  PesanSenderBloc(
    PesanRepository pesanRepository,
  )   : _pesanRepository = pesanRepository,
        super(PesanInitial()) {
    on<PesanSent>(_onPesanSentToState);
  }

  FutureOr<void> _onPesanSentToState(
    PesanSent event,
    Emitter<PesanSenderState> emit,
  ) async {
    try {
      emit(PesanSentInprogress());
      await _pesanRepository.addPesan(pesan: event.pesan);
      emit(PesanSentSuccess());
    } on Exception catch (e, stackTrace) {
      log('Issue while sending Pesan ${e.toString()} $stackTrace');
      emit(PesanSentFailure(pesan: e.toString()));
    }
  }
}
