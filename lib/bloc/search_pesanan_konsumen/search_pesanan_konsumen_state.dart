part of 'search_pesanan_konsumen_bloc.dart';

abstract class SearchPesananKonsumenState extends Equatable {
  const SearchPesananKonsumenState();

  @override
  List<Object?> get props => [];
}

class SearchPesananKonsumenLoading extends SearchPesananKonsumenState {}

class SearchPesananKonsumenLoaded extends SearchPesananKonsumenState {
  final List<Pesanan> pesanan;

  const SearchPesananKonsumenLoaded({this.pesanan = const <Pesanan>[]});

  @override
  List<Object?> get props => [pesanan];
}
