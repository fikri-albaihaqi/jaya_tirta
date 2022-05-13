import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/konsumen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KonsumenRepository {
  final FirebaseFirestore _firebaseFirestore;

  KonsumenRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Konsumen>> getAllKonsumen() {
    return _firebaseFirestore.collection('konsumen').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Konsumen.fromSnapshot(doc)).toList());
  }

  getKonsumenPesan(String id) {
    return _firebaseFirestore.collection('konsumen').doc(id).get().then(
          (doc) => Konsumen.fromSnapshot(doc),
        );
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

  Future<List<String>> loadDataKonsumen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> konsumen = [];

    return Future.delayed(const Duration(milliseconds: 600), () {
      konsumen.add(prefs.getString('id')!);
      konsumen.add(prefs.getString('nama')!);
      konsumen.add(prefs.getString('alamat')!);
      konsumen.add(prefs.getString('noTelp')!);

      return konsumen;
    });
  }

  Future<void> storeDataKonsumen(Konsumen konsumen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', konsumen.id!);
    prefs.setString('nama', konsumen.nama!);
    prefs.setString('alamat', konsumen.alamat!);
    prefs.setString('noTelp', konsumen.noTelp!);
  }
}
