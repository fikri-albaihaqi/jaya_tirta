part of 'crud_pesanan_bloc.dart';

abstract class CrudPesananState extends Equatable {
  const CrudPesananState();

  @override
  List<Object?> get props => [];
}

class CrudPesananLoading extends CrudPesananState {}

class CrudPesananLoaded extends CrudPesananState {
  final String? id;
  final String? status;
  final String? jumlah;
  final String? total;
  final String? tanggalPembelian;
  final String? idProduk;
  final String? namaProduk;
  final String? gambar;
  final String? harga;
  final String? stok;
  final String? idKonsumen;
  final String? namaKonsumen;
  final String? alamat;
  final String? noTelp;
  final String? keckelurahan;
  final Pesanan pesanan;

  CrudPesananLoaded(
      {this.id,
      this.status,
      this.jumlah,
      this.total,
      this.tanggalPembelian,
      this.idProduk,
      this.namaProduk,
      this.gambar,
      this.harga,
      this.stok,
      this.idKonsumen,
      this.namaKonsumen,
      this.alamat,
      this.noTelp,
      this.keckelurahan})
      : pesanan = Pesanan(
          id: id,
          status: status,
          jumlah: jumlah,
          total: total,
          tanggalPembelian: tanggalPembelian,
          idProduk: idProduk,
          namaProduk: namaProduk,
          gambar: gambar,
          harga: harga,
          stok: stok,
          idKonsumen: idKonsumen,
          namaKonsumen: namaKonsumen,
          alamat: alamat,
          noTelp: noTelp,
          keckelurahan: keckelurahan,
        );

  @override
  List<Object?> get props => [
        id,
        status,
        jumlah,
        total,
        tanggalPembelian,
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
      ];
}
