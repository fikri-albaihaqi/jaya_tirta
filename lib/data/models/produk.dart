import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Produk extends Equatable {
  final String? id;
  final String? namaProduk;
  final String? gambar;
  final int? harga;
  final int? stok;

  const Produk({
    this.id,
    required this.namaProduk,
    required this.gambar,
    required this.harga,
    required this.stok,
  });

  static Produk fromSnapshot(DocumentSnapshot snap) {
    Produk produk = Produk(
      id: snap.id,
      namaProduk: snap['namaProduk'],
      gambar: snap['gambar'],
      harga: snap['harga'],
      stok: snap['stok'],
    );
    return produk;
  }

  @override
  List<Object?> get props => [
        id,
        namaProduk,
        gambar,
        harga,
        stok,
      ];

  static List<Produk> produks = [
    const Produk(
      id: '1',
      namaProduk: 'Galon Prima 19 Liter',
      gambar: 'graphics/prima.png',
      harga: 17000,
      stok: 250,
    ),
  ];

  Map<String, Object> toDocument() {
    return {
      'namaProduk': namaProduk!,
      'gambar': gambar!,
      'harga': harga!,
      'stok': stok!,
    };
  }
}
