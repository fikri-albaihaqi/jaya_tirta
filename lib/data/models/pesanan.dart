import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Pesanan extends Equatable {
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

  const Pesanan({
    this.id,
    required this.status,
    required this.jumlah,
    required this.total,
    required this.idProduk,
    required this.namaProduk,
    required this.gambar,
    required this.harga,
    required this.stok,
    required this.idKonsumen,
    required this.namaKonsumen,
    required this.alamat,
    required this.noTelp,
  });

  static Pesanan fromSnapshot(DocumentSnapshot snap) {
    Pesanan pesanan = Pesanan(
      id: snap.id,
      status: snap['status'],
      jumlah: snap['jumlah'],
      total: snap['total'],
      idProduk: snap['produk']['idProduk'],
      namaProduk: snap['produk']['namaProduk'],
      gambar: snap['produk']['gambar'],
      harga: snap['produk']['harga'],
      stok: snap['produk']['stok'],
      idKonsumen: snap['konsumen']['idKonsumen'],
      namaKonsumen: snap['konsumen']['namaKonsumen'],
      alamat: snap['konsumen']['alamat'],
      noTelp: snap['konsumen']['noTelp'],
    );
    return pesanan;
  }

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

    return {
      'status': status!,
      'jumlah': jumlah!,
      'total': total!,
      'produk': produk,
      'konsumen': konsumen,
    };
  }
}
