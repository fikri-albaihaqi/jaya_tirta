part of 'pesanan_bloc.dart';

abstract class PesananEvent extends Equatable {
  const PesananEvent();

  @override
  List<Object?> get props => [];
}

class LoadPesanan extends PesananEvent {}

class LoadedPesanan extends PesananEvent {
  final List<Pesanan> pesanan;

  const LoadedPesanan(this.pesanan);

  @override
  List<Object> get props => [pesanan];
}
