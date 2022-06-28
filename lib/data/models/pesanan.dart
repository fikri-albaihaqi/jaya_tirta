import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Pesanan extends Equatable {
  final String? id;
  final String? status;
  final int? jumlah;
  final int? total;
  final String? tanggalPembelian;
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

  const Pesanan({
    this.id,
    required this.status,
    required this.jumlah,
    required this.total,
    required this.tanggalPembelian,
    required this.idProduk,
    required this.namaProduk,
    required this.gambar,
    required this.harga,
    required this.stok,
    required this.idKonsumen,
    required this.namaKonsumen,
    required this.alamat,
    required this.noTelp,
    required this.keckelurahan,
    this.jumlahPinjaman,
  });

  static Pesanan fromSnapshot(DocumentSnapshot snap) {
    Pesanan pesanan = Pesanan(
      id: snap.id,
      status: snap['status'],
      jumlah: snap['jumlah'],
      total: snap['total'],
      tanggalPembelian: snap['tanggalPembelian'],
      idProduk: snap['produk']['idProduk'],
      namaProduk: snap['produk']['namaProduk'],
      gambar: snap['produk']['gambar'],
      harga: snap['produk']['harga'],
      stok: snap['produk']['stok'],
      idKonsumen: snap['konsumen']['idKonsumen'],
      namaKonsumen: snap['konsumen']['namaKonsumen'],
      alamat: snap['konsumen']['alamat'],
      noTelp: snap['konsumen']['noTelp'],
      keckelurahan: snap['konsumen']['keckelurahan'],
      jumlahPinjaman: snap['konsumen']['jumlahPinjaman'],
    );
    return pesanan;
  }

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
        jumlahPinjaman,
      ];

  Map<String, Object> toDocument() {
    Map produk = Map();
    produk['idProduk'] = idProduk;
    produk['namaProduk'] = namaProduk;
    produk['gambar'] = gambar;
    produk['harga'] = harga;
    produk['stok'] = stok;

    Map konsumen = Map();
    konsumen['idKonsumen'] = idKonsumen;
    konsumen['namaKonsumen'] = namaKonsumen;
    konsumen['alamat'] = alamat;
    konsumen['noTelp'] = noTelp;
    konsumen['keckelurahan'] = keckelurahan;
    konsumen['jumlahPinjaman'] = jumlahPinjaman;

    return {
      'status': status!,
      'jumlah': jumlah!,
      'total': total!,
      'tanggalPembelian': tanggalPembelian!,
      'produk': produk,
      'konsumen': konsumen,
    };
  }
}
