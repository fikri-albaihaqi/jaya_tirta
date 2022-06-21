part of 'penjual_bloc.dart';

abstract class PenjualState extends Equatable {
  const PenjualState();

  @override
  List<Object> get props => [];
}

class PenjualLoading extends PenjualState {}

class PenjualLoaded extends PenjualState {
  final List<Penjual> penjual;

  const PenjualLoaded({this.penjual = const <Penjual>[]});

  @override
  List<Object> get props => [penjual];
}
