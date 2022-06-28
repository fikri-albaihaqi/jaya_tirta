part of 'crud_penjualan_bulanan_bloc.dart';

abstract class CrudPenjualanBulananState extends Equatable {
  const CrudPenjualanBulananState();

  @override
  List<Object?> get props => [];
}

class CrudPenjualanBulananLoading extends CrudPenjualanBulananState {}

class CrudPenjualanBulananLoaded extends CrudPenjualanBulananState {
  final String? id;
  final String? tanggal;
  final int? jumlahPenjualan;
  final PenjualanBulanan? penjualanBulanan;

  CrudPenjualanBulananLoaded({
    this.id,
    this.tanggal,
    this.jumlahPenjualan,
  }) : penjualanBulanan = PenjualanBulanan(
          id: id,
          tanggal: tanggal,
          jumlahPenjualan: jumlahPenjualan,
        );

  @override
  List<Object?> get props => [
        id,
        tanggal,
        jumlahPenjualan,
      ];
}
