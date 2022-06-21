part of 'filter_pesanan_konsumen_bloc.dart';

abstract class FilterPesananKonsumenState extends Equatable {
  const FilterPesananKonsumenState();

  @override
  List<Object?> get props => [];
}

class FilterPesananKonsumenLoading extends FilterPesananKonsumenState {}

class FilterPesananKonsumenLoaded extends FilterPesananKonsumenState {
  final Filter filter;
  final List<Pesanan>? filteredPesanan;

  FilterPesananKonsumenLoaded({
    this.filter = const Filter(),
    this.filteredPesanan = const <Pesanan>[],
  });

  @override
  List<Object?> get props => [filter, filteredPesanan];
}
