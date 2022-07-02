part of 'crud_pesanan_bloc.dart';

abstract class CrudPesananEvent extends Equatable {
  const CrudPesananEvent();

  @override
  List<Object?> get props => [];
}

class AddPesanan extends CrudPesananEvent {
  final String? id;
  final String? status;
  final int? jumlah;
  final int? total;
  final String? tanggalPembelian;
  final String? timestamp;
  final String? dateSort;
  final String? idProduk;
  final String? namaProduk;
  final String? gambar;
  final int? harga;
  final int? stok;
  final String? idKonsumen;
  final String? namaKonsumen;
  final String? alamat;
  final String? noTelp;
  final String? keckelurahan;
  final int? jumlahPinjaman;

  const AddPesanan({
    this.id,
    this.status,
    this.jumlah,
    this.total,
    this.tanggalPembelian,
    this.timestamp,
    this.dateSort,
    this.idProduk,
    this.namaProduk,
    this.gambar,
    this.harga,
    this.stok,
    this.idKonsumen,
    this.namaKonsumen,
    this.alamat,
    this.noTelp,
    this.keckelurahan,
    this.jumlahPinjaman,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        jumlah,
        total,
        tanggalPembelian,
        timestamp,
        dateSort,
        idProduk,
        namaProduk,
        gambar,
        harga,
        stok,
        idKonsumen,
        namaKonsumen,
        alamat,
        noTelp,
        keckelurahan,
        jumlahPinjaman,
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
  final int? jumlah;
  final int? total;
  final String? tanggalPembelian;
  final String? timestamp;
  final String? dateSort;
  final String? idProduk;
  final String? namaProduk;
  final String? gambar;
  final int? harga;
  final int? stok;
  final String? idKonsumen;
  final String? namaKonsumen;
  final String? alamat;
  final String? noTelp;
  final String? keckelurahan;
  final int? jumlahPinjaman;

  const UpdatePesanan({
    this.id,
    this.status,
    this.jumlah,
    this.total,
    this.tanggalPembelian,
    this.timestamp,
    this.dateSort,
    this.idProduk,
    this.namaProduk,
    this.gambar,
    this.harga,
    this.stok,
    this.idKonsumen,
    this.namaKonsumen,
    this.alamat,
    this.noTelp,
    this.keckelurahan,
    this.jumlahPinjaman,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        jumlah,
        total,
        tanggalPembelian,
        timestamp,
        dateSort,
        idProduk,
        namaProduk,
        gambar,
        harga,
        stok,
        idKonsumen,
        namaKonsumen,
        alamat,
        noTelp,
        keckelurahan,
        jumlahPinjaman,
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
