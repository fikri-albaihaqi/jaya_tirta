import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/models.dart';

class PenjualRepository {
  final FirebaseFirestore _firebaseFirestore;

  PenjualRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Penjual>> getAllPenjual() {
    return _firebaseFirestore.collection('penjual').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Penjual.fromSnapshot(doc)).toList());
  }

  Stream<List<Penjual>> getProfil(String id) {
    return _firebaseFirestore
        .collection('penjual')
        .where('id', isEqualTo: id)
        .snapshots()
        .map((snapshots) {
      return snapshots.docs.map((docs) => Penjual.fromSnapshot(docs)).toList();
    });
  }

  Future<void> addPenjual(Penjual penjual) {
    return _firebaseFirestore.collection('penjual').doc(penjual.id).set({
      'id': penjual.id,
      'nama': penjual.nama,
      'noTelp': penjual.noTelp,
    });
  }

  Future<void> deletePenjual(String id) {
    return _firebaseFirestore.collection('penjual').doc(id).delete();
  }

  Future<void> updatePenjual(Penjual penjual, String id) {
    return _firebaseFirestore
        .collection('penjual')
        .doc(id)
        .update(
          {
            'id': id,
            'nama': penjual.nama,
            'noTelp': penjual.noTelp,
          },
        )
        .then((_) => print(penjual.nama))
        .catchError((onError) => print('Update failed: $onError'));
  }
}
