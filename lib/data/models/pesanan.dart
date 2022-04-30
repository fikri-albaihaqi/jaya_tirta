import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';

class Pesanan extends Equatable {
  final Produk produk;
  final String? id;
  final String? status;
  final String? jumlah;
  final String? total;

  const Pesanan(
      {this.id, this.status, required this.produk, this.jumlah, this.total});

  static Pesanan fromSnapshot(DocumentSnapshot snap) {
    Pesanan pesanan = Pesanan(
      id: snap.id,
      status: snap['status'],
      produk: snap['idProduk'],
      jumlah: snap['jumlah'],
      total: snap['total'],
    );
    return pesanan;
  }

  @override
  List<Object?> get props => [
        id,
        status,
        produk,
        jumlah,
        total,
      ];

  // Map produkQuantity(produks) {
  //   var quantity = Map();

  //   if (!quantity.containsKey(produk)) {
  //     quantity[produk] = 1;
  //   } else {
  //     quantity[produk] += 1;
  //   }
  //   return quantity;
  // }
}
