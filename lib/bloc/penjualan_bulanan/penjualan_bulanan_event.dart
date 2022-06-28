part of 'penjualan_bulanan_bloc.dart';

abstract class PenjualanBulananEvent extends Equatable {
  const PenjualanBulananEvent();

  @override
  List<Object> get props => [];
}

class LoadAllPenjualanBulanan extends PenjualanBulananEvent {}

class LoadPenjualanBulanan extends PenjualanBulananEvent {}

class LoadedPenjualanBulanan extends PenjualanBulananEvent {
  final PenjualanBulanan penjualanBulanan;

  const LoadedPenjualanBulanan(this.penjualanBulanan);

  @override
  List<Object> get props => [penjualanBulanan];
}
