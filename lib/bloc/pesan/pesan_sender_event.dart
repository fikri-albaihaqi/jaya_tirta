part of 'pesan_sender_bloc.dart';

abstract class PesanSenderEvent extends Equatable {
  const PesanSenderEvent();

  @override
  List<Object> get props => [];
}

class PesanSent extends PesanSenderEvent {
  final Pesan pesan;
  const PesanSent({
    required this.pesan,
  });
}
