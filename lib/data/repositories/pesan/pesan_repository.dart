import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/models.dart';

class PesanRepository {
  final FirebaseFirestore _firestore;

  PesanRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> addPesan({required Pesan pesan}) async {
    await _firestore.collection('pesan').add(pesan.toMap());
  }

  Stream<List<Pesan?>> getPesans({
    required String obrolanId,
  }) {
    final querySnapShotStream = _firestore
        .collection('pesan')
        .where('obrolanId', isEqualTo: obrolanId)
        .orderBy('timestamp', descending: true)
        .snapshots();

    return querySnapShotStream.map(
      (event) => event.docs.map((e) => Pesan.fromMap(e.data())).toList(),
    );
  }
}
