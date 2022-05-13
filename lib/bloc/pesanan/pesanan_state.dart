part of 'pesanan_bloc.dart';

abstract class PesananState extends Equatable {
  const PesananState();

  @override
  List<Object?> get props => [];
}

class PesananLoading extends PesananState {}

class PesananLoaded extends PesananState {
  final List<Pesanan> pesanan;

  const PesananLoaded({this.pesanan = const <Pesanan>[]});

  @override
  List<Object> get props => [pesanan];
}
