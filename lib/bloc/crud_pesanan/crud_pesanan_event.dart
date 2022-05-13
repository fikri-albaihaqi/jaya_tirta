part of 'crud_pesanan_bloc.dart';

abstract class CrudPesananEvent extends Equatable {
  const CrudPesananEvent();

  @override
  List<Object?> get props => [];
}

class AddPesanan extends CrudPesananEvent {
  final String? id;
  final String? status;
  final String? jumlah;
  final String? total;
  final String? idProduk;
  final String? namaProduk;
  final String? gambar;
  final String? harga;
  final String? stok;
  final String? idKonsumen;
  final String? namaKonsumen;
  final String? alamat;
  final String? noTelp;

  const AddPesanan({
    this.id,
    this.status,
    this.jumlah,
    this.total,
    this.idProduk,
    this.namaProduk,
    this.gambar,
    this.harga,
    this.stok,
    this.idKonsumen,
    this.namaKonsumen,
    this.alamat,
    this.noTelp,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        jumlah,
        total,
        idProduk,
        namaProduk,
        gambar,
        harga,
        stok,
        idKonsumen,
        namaKonsumen,
        alamat,
        noTelp,
      ];
}

class ConfirmAddPesanan extends CrudPesananEvent {
  final Pesanan pesanan;

  const ConfirmAddPesanan({required this.pesanan});

  @override
  List<Object> get props => [pesanan];
}

class UpdatePesanan extends CrudPesananEvent {
  final String? id;
  final String? status;
  final String? jumlah;
  final String? total;
  final Produk? produk;
  final Konsumen? konsumen;

  const UpdatePesanan({
    this.id,
    this.status,
    this.jumlah,
    this.total,
    this.produk,
    this.konsumen,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        jumlah,
        total,
        produk,
        konsumen,
      ];
}

class ConfirmUpdatePesanan extends CrudPesananEvent {
  final Pesanan pesanan;
  final String? id;

  const ConfirmUpdatePesanan({required this.pesanan, required this.id});

  @override
  List<Object> get props => [pesanan];
}

class DeletePesanan extends CrudPesananEvent {
  final String id;

  const DeletePesanan({required this.id});

  @override
  List<Object> get props => [];
}
