import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/obrolan/obrolan_repository.dart';

part 'obrolan_event.dart';
part 'obrolan_state.dart';

class ObrolanBloc extends Bloc<ObrolanEvent, ObrolanState> {
  final ObrolanRepository _obrolanRepository;
  ObrolanBloc({required ObrolanRepository obrolanRepository})
      : _obrolanRepository = obrolanRepository,
        super(ObrolanInitial()) {
    on<ObrolanDetailRequested>(_onObrolanDetailRequested);
    on<ObrolanCreated>(_onObrolanCreated);
  }

  FutureOr<void> _onObrolanDetailRequested(
    ObrolanDetailRequested event,
    Emitter<ObrolanState> emit,
  ) async {
    try {
      emit(ObrolanLoadInprogress());
      final obrolanDetail = await _obrolanRepository.getObrolan(
        senderUID: event.loginUser.uid,
        receiverUID: event.receiver.uid,
      );

      if (obrolanDetail != null) {
        emit(ObrolanLoadSuccess(obrolan: obrolanDetail));
      } else {
        add(
          ObrolanCreated(
            obrolan: Obrolan(
              creator: event.loginUser,
              receiver: event.receiver,
              members: [event.loginUser.uid, event.receiver.uid],
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      log('Issue whiel fetching covnersation detail ${e.toString()}');
      log('Stack trace is ${stackTrace.toString()}');
      emit(
        const ObrolanLoadFailure(message: 'Unable to load Obrolan'),
      );
    }
  }

  FutureOr<void> _onObrolanCreated(
    ObrolanCreated event,
    Emitter<ObrolanState> emit,
  ) async {
    emit(ObrolanCreationInprogress());

    final obrolanId = await _obrolanRepository.createObrolan(
      obrolan: event.obrolan,
    );
    emit(ObrolanCreationSuccess(obrolanId: obrolanId));
  }
}
