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

  Stream<List<Konsumen>> getProfil(String id) {
    return _firebaseFirestore
        .collection('konsumen')
        .where('id', isEqualTo: id)
        .snapshots()
        .map((snapshots) {
      return snapshots.docs.map((docs) => Konsumen.fromSnapshot(docs)).toList();
    });
  }

  Future<void> addKonsumen(Konsumen konsumen) {
    return _firebaseFirestore.collection('konsumen').doc(konsumen.id).set({
      'id': konsumen.id,
      'nama': konsumen.nama,
      'alamat': konsumen.alamat,
      'noTelp': konsumen.noTelp,
      'keckelurahan': konsumen.keckelurahan,
      'jumlahPinjaman': konsumen.jumlahPinjaman,
    });
  }

  Future<void> deleteKonsumen(String id) {
    return _firebaseFirestore.collection('konsumen').doc(id).delete();
  }

  Future<void> updateKonsumen(Konsumen konsumen, String id) {
    if (konsumen.jumlahPinjaman != null) {
      return _firebaseFirestore.collection('konsumen').doc(id).update(
        {
          'id': id,
          'nama': konsumen.nama,
          'alamat': konsumen.alamat,
          'noTelp': konsumen.noTelp,
          'keckelurahan': konsumen.keckelurahan,
          'jumlahPinjaman': konsumen.jumlahPinjaman,
        },
      );
    } else {
      return _firebaseFirestore.collection('konsumen').doc(id).update(
        {
          'id': id,
          'nama': konsumen.nama,
          'alamat': konsumen.alamat,
          'noTelp': konsumen.noTelp,
          'keckelurahan': konsumen.keckelurahan,
        },
      );
    }
  }

  Future<List<String>> loadDataKonsumen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> konsumen = [];

    if (prefs.getString('id') != null) {
      return Future.delayed(const Duration(milliseconds: 600), () {
        konsumen.add(prefs.getString('id')!);
        konsumen.add(prefs.getString('nama')!);
        konsumen.add(prefs.getString('alamat')!);
        konsumen.add(prefs.getString('noTelp')!);
        konsumen.add(prefs.getString('keckelurahan')!);

        return konsumen;
      });
    } else {
      return konsumen;
    }
  }

  Future<void> storeDataKonsumen(Konsumen konsumen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', konsumen.id!);
    prefs.setString('nama', konsumen.nama!);
    prefs.setString('alamat', konsumen.alamat!);
    prefs.setString('noTelp', konsumen.noTelp!);
    prefs.setString('keckelurahan', konsumen.keckelurahan!);
  }
}
