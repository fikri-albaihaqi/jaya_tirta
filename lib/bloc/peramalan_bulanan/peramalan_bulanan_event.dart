part of 'peramalan_bulanan_bloc.dart';

abstract class PeramalanBulananEvent extends Equatable {
  const PeramalanBulananEvent();

  @override
  List<Object> get props => [];
}

class LoadPeramalanBulanan extends PeramalanBulananEvent {}

class LoadedPeramalanBulanan extends PeramalanBulananEvent {
  final List<Ramalan> peramalan;

  const LoadedPeramalanBulanan(this.peramalan);

  @override
  List<Object> get props => [peramalan];
}
