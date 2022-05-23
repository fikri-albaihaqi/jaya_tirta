part of 'pesanan_konsumen_bloc.dart';

abstract class PesananKonsumenEvent extends Equatable {
  const PesananKonsumenEvent();

  @override
  List<Object> get props => [];
}

class LoadPesananKonsumen extends PesananKonsumenEvent {
  final String? idKonsumen;

  const LoadPesananKonsumen(this.idKonsumen);

  @override
  List<Object> get props => [];
}

class LoadedPesananKonsumen extends PesananKonsumenEvent {
  final List<Pesanan> pesanan;

  const LoadedPesananKonsumen(this.pesanan);

  @override
  List<Object> get props => [pesanan];
}
