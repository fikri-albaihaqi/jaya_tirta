import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/produk.dart';
import 'package:jaya_tirta/data/repositories/produk/base_produk_repository.dart';

class ProdukRepository extends BaseProdukRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProdukRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Produk>> getAllProduk() {
    return _firebaseFirestore.collection('produk').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Produk.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> addProduk(Produk produk) {
    return _firebaseFirestore.collection('produk').add(produk.toDocument());
  }

  @override
  Future<void> deleteProduk(String id) {
    return _firebaseFirestore.collection('produk').doc(id).delete();
  }

  @override
  Future<void> updateProduk(Produk produk, String id) {
    return _firebaseFirestore
        .collection('produk')
        .doc(id)
        .update(
          {
            'namaProduk': produk.namaProduk,
            'gambar': produk.gambar,
            'stok': produk.stok,
            'harga': produk.harga,
          },
        )
        .then((_) => print(produk.namaProduk))
        .catchError((onError) => print('Update failed: $onError'));
  }
}
