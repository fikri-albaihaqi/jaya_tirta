part of 'pesan_receiver_bloc.dart';

abstract class PesanReceiverEvent extends Equatable {
  const PesanReceiverEvent();

  @override
  List<Object> get props => [];
}

class PesanRequested extends PesanReceiverEvent {
  final String obrolanId;
  const PesanRequested({
    required this.obrolanId,
  });
}

class PesanReceived extends PesanReceiverEvent {
  final List<Pesan?> pesans;
  const PesanReceived({
    required this.pesans,
  });
}
