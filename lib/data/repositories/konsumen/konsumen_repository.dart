import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/konsumen.dart';

class KonsumenRepository {
  final FirebaseFirestore _firebaseFirestore;

  KonsumenRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Konsumen>> getAllKonsumen() {
    return _firebaseFirestore
        .collection('konsumen')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final model = Konsumen.fromSnapshot(doc);
        model.id = doc.id;
        return model;
      }).toList();
    });
  }

  Future<void> getKonsumen(String id) {
    return _firebaseFirestore.collection('konsumen').doc(id).get();
  }

  Future<void> addKonsumen(Konsumen konsumen) {
    return _firebaseFirestore.collection('konsumen').add(konsumen.toDocument());
  }

  Future<void> deleteKonsumen(String id) {
    return _firebaseFirestore.collection('konsumen').doc(id).delete();
  }

  Future<void> updateKonsumen(Konsumen konsumen, String id) {
    return _firebaseFirestore
        .collection('konsumen')
        .doc(id)
        .update(
          {
            'nama': konsumen.nama,
            'alamat': konsumen.alamat,
            'noTelp': konsumen.noTelp,
          },
        )
        .then((_) => print(konsumen.nama))
        .catchError((onError) => print('Update failed: $onError'));
  }
}
