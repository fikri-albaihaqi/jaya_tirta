part of 'crud_penjualan_bulanan_bloc.dart';

abstract class CrudPenjualanBulananEvent extends Equatable {
  const CrudPenjualanBulananEvent();

  @override
  List<Object?> get props => [];
}

class AddPenjualanBulanan extends CrudPenjualanBulananEvent {
  final String? id;
  final String? tanggal;
  final int? jumlahPenjualan;

  const AddPenjualanBulanan({
    this.id,
    this.tanggal,
    this.jumlahPenjualan,
  });

  @override
  List<Object?> get props => [
        id,
        tanggal,
        jumlahPenjualan,
      ];
}

class ConfirmAddPenjualanBulanan extends CrudPenjualanBulananEvent {
  final PenjualanBulanan penjualanBulanan;

  const ConfirmAddPenjualanBulanan({required this.penjualanBulanan});

  @override
  List<Object> get props => [penjualanBulanan];
}

class UpdatePenjualanBulanan extends CrudPenjualanBulananEvent {
  final String? id;
  final String? tanggal;
  final int? jumlahPenjualan;

  const UpdatePenjualanBulanan({
    this.id,
    this.tanggal,
    this.jumlahPenjualan,
  });

  @override
  List<Object?> get props => [
        id,
        tanggal,
        jumlahPenjualan,
      ];
}

class ConfirmUpdatePenjualanBulanan extends CrudPenjualanBulananEvent {
  final PenjualanBulanan penjualanBulanan;
  final String? id;

  const ConfirmUpdatePenjualanBulanan(
      {required this.penjualanBulanan, required this.id});

  @override
  List<Object> get props => [penjualanBulanan];
}

class UpdateJumlahPenjualan extends CrudPenjualanBulananEvent {
  final String? id;
  final int? jumlahPenjualan;

  const UpdateJumlahPenjualan(
      {required this.id, required this.jumlahPenjualan});

  @override
  List<Object> get props => [];
}

class DeletePenjualanBulanan extends CrudPenjualanBulananEvent {
  final String id;

  const DeletePenjualanBulanan({required this.id});

  @override
  List<Object> get props => [];
}
