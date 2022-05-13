import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/models.dart';

class PesananRepository {
  final FirebaseFirestore _firebaseFirestore;

  PesananRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Pesanan>> getAllPesanan() {
    return _firebaseFirestore.collection('pesanan').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Pesanan.fromSnapshot(doc);
      }).toList();
    });
  }

  Future<void> addPesanan(Pesanan pesanan) async {
    return _firebaseFirestore
        .collection('pesanan')
        .add(pesanan.toDocument())
        .then((value) => print(pesanan));
  }

  Future<void> deletePesanan(String id) {
    return _firebaseFirestore.collection('pesanan').doc(id).delete();
  }

  // @override
  // Future<void> updatePesanan(Pesanan pesanan, String id) {
  //   return _firebaseFirestore
  //       .collection('pesanan')
  //       .doc(id)
  //       .update(
  //         {
  //           'status': pesanan.status,
  //           'jumlah': pesanan.jumlah,
  //           'total': pesanan.total,
  //           'produk': pesanan.produk,
  //           'konsumen': pesanan.konsumen,
  //         },
  //       )
  //       .then((_) => print(pesanan.status))
  //       .catchError((onError) => print('Update failed: $onError'));
  // }
}
