part of 'crud_pesanan_bloc.dart';

abstract class CrudPesananEvent extends Equatable {
  const CrudPesananEvent();

  @override
  List<Object> get props => [];
}

class LoadCrudPesanan extends CrudPesananEvent {}

class LoadedCrudPesanan extends CrudPesananEvent {
  final List<Konsumen> konsumen;

  LoadedCrudPesanan(this.konsumen);

  @override
  List<Object> get props => [konsumen];
}
