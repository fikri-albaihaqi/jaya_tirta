import 'package:jaya_tirta/data/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PeramalanRepository {
  final FirebaseFirestore _firebaseFirestore;

  PeramalanRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Peramalan>> getRamalanBulanan() {
    return _firebaseFirestore
        .collection('ramalanBulanan')
        .orderBy('bulanKe')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Peramalan.fromSnapshot(doc)).toList();
    });
  }
}
