part of 'peramalan_mingguan_bloc.dart';

abstract class PeramalanMingguanEvent extends Equatable {
  const PeramalanMingguanEvent();

  @override
  List<Object> get props => [];
}

class LoadPeramalanMingguan extends PeramalanMingguanEvent {}

class LoadedPeramalanMingguan extends PeramalanMingguanEvent {
  final List<Ramalan> peramalan;

  const LoadedPeramalanMingguan(this.peramalan);

  @override
  List<Object> get props => [peramalan];
}
