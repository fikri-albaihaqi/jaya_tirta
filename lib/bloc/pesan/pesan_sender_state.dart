part of 'pesan_sender_bloc.dart';

abstract class PesanSenderState extends Equatable {
  const PesanSenderState();

  @override
  List<Object> get props => [];
}

class PesanInitial extends PesanSenderState {}

class PesanSentSuccess extends PesanSenderState {}

class PesanSentFailure extends PesanSenderState {
  final String pesan;
  const PesanSentFailure({
    required this.pesan,
  });
}

class PesanSentInprogress extends PesanSenderState {}
