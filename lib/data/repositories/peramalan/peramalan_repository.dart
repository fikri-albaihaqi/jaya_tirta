import 'package:jaya_tirta/data/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PeramalanRepository {
  final FirebaseFirestore _firebaseFirestore;

  PeramalanRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Ramalan>> getRamalanBulanan() {
    return _firebaseFirestore
        .collection('ramalanBulanan')
        .orderBy('bulan')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Ramalan.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Ramalan>> getRamalanMingguan() {
    return _firebaseFirestore
        .collection('ramalanMingguan')
        .orderBy('bulan')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Ramalan.fromSnapshot(doc)).toList();
    });
  }
}
