part of 'pesanan_konsumen_bloc.dart';

abstract class PesananKonsumenState extends Equatable {
  const PesananKonsumenState();

  @override
  List<Object> get props => [];
}

class PesananKonsumenLoading extends PesananKonsumenState {}

class PesananKonsumenLoaded extends PesananKonsumenState {
  final List<Pesanan> pesanan;

  const PesananKonsumenLoaded({this.pesanan = const <Pesanan>[]});

  @override
  List<Object> get props => [pesanan];
}
