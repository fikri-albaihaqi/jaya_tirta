part of 'penjual_bloc.dart';

abstract class PenjualEvent extends Equatable {
  const PenjualEvent();

  @override
  List<Object> get props => [];
}

class LoadAllPenjual extends PenjualEvent {}

class LoadPenjual extends PenjualEvent {
  final String? id;

  const LoadPenjual({required this.id});

  @override
  List<Object> get props => [];
}

class LoadedPenjual extends PenjualEvent {
  final List<Penjual> penjual;

  const LoadedPenjual(this.penjual);

  @override
  List<Object> get props => [penjual];
}
