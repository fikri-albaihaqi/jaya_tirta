part of 'crud_pesanan_bloc.dart';

abstract class CrudPesananState extends Equatable {
  const CrudPesananState();

  @override
  List<Object> get props => [];
}

class CrudPesananLoading extends CrudPesananState {}

class CrudPesananLoaded extends CrudPesananState {
  final List<Konsumen> konsumen;

  CrudPesananLoaded({this.konsumen = const <Konsumen>[]});

  @override
  List<Object> get props => [konsumen];
}
