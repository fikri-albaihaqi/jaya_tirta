part of 'search_pesanan_konsumen_bloc.dart';

abstract class SearchPesananKonsumenEvent extends Equatable {
  const SearchPesananKonsumenEvent();

  @override
  List<Object?> get props => [];
}

class LoadPesananKonsumenSearch extends SearchPesananKonsumenEvent {}

class SearchPesananKonsumen extends SearchPesananKonsumenEvent {
  final String? parameter;

  const SearchPesananKonsumen({
    this.parameter,
  });

  @override
  List<Object?> get props => [
        parameter,
      ];
}

class UpdatePesananKonsumenResults extends SearchPesananKonsumenEvent {
  final List<Pesanan> pesanan;

  const UpdatePesananKonsumenResults(this.pesanan);

  @override
  List<Object?> get props => [pesanan];
}
