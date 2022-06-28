part of 'penjualan_bulanan_bloc.dart';

abstract class PenjualanBulananState extends Equatable {
  const PenjualanBulananState();

  @override
  List<Object> get props => [];
}

class PenjualanBulananLoading extends PenjualanBulananState {}

class PenjualanBulananLoaded extends PenjualanBulananState {
  final PenjualanBulanan penjualanBulanan;

  const PenjualanBulananLoaded({required this.penjualanBulanan});

  @override
  List<Object> get props => [penjualanBulanan];
}
