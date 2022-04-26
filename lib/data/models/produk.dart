import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Produk extends Equatable {
  String? _id = '';
  String? get id => _id;
  set id(String? value) {
    _id = value;
  }

  final String? namaProduk;
  final String? gambar;
  final String? harga;
  final String? stok;

  Produk({
    required this.namaProduk,
    required this.gambar,
    required this.harga,
    required this.stok,
  });

  static Produk fromSnapshot(DocumentSnapshot snap) {
    Produk produk = Produk(
      namaProduk: snap['namaProduk'],
      gambar: snap['gambar'],
      harga: snap['harga'],
      stok: snap['stok'],
    );
    return produk;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        namaProduk,
        gambar,
        harga,
        stok,
      ];

  static List<Produk> produks = [
    Produk(
      namaProduk: 'Galon Prima 19 Liter',
      gambar: 'graphics/prima.png',
      harga: '17000',
      stok: '250',
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
