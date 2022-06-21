part of 'filter_pesanan_konsumen_bloc.dart';

abstract class FilterPesananKonsumenEvent extends Equatable {
  const FilterPesananKonsumenEvent();

  @override
  List<Object> get props => [];
}

class LoadFilterPesananKonsumen extends FilterPesananKonsumenEvent {
  @override
  List<Object> get props => [];
}

class UpdateStatusFilterPesananKonsumen extends FilterPesananKonsumenEvent {
  final StatusFilter statusFilter;

  const UpdateStatusFilterPesananKonsumen({required this.statusFilter});

  @override
  List<Object> get props => [statusFilter];
}
