import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/produk.dart';

class ProdukRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProdukRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Produk>> getAllProduk() {
    return _firebaseFirestore.collection('produk').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Produk.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduk(Produk produk) {
    return _firebaseFirestore.collection('produk').add(produk.toDocument());
  }

  Future<void> deleteProduk(String id) {
    return _firebaseFirestore.collection('produk').doc(id).delete();
  }

  Future<void> updateProduk(Produk produk, String id) {
    return _firebaseFirestore.collection('produk').doc(id).update(
      {
        'namaProduk': produk.namaProduk,
        'gambar': produk.gambar,
        'stok': produk.stok,
        'harga': produk.harga,
      },
    );
  }
}
