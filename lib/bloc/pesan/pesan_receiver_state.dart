part of 'pesan_receiver_bloc.dart';

abstract class PesanReceiverState extends Equatable {
  const PesanReceiverState();

  @override
  List<Object> get props => [];
}

class PesanReceiverInitial extends PesanReceiverState {}

class PesanLoadSuccess extends PesanReceiverState {
  final List<Pesan?> pesans;
  const PesanLoadSuccess({
    required this.pesans,
  });
  @override
  List<Object> get props => [pesans];
}

class PesanLoadInprogress extends PesanReceiverState {}

class PesanLoadFailure extends PesanReceiverState {
  final String pesan;
  const PesanLoadFailure({
    required this.pesan,
  });
}
