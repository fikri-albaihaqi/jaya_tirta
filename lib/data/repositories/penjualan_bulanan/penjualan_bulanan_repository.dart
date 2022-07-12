import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/models.dart';

class PenjualanBulananRepository {
  final FirebaseFirestore _firebaseFirestore;
  FirebaseStorage storage = FirebaseStorage.instance;

  PenjualanBulananRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<PenjualanBulanan>> getAllPenjualanBulanan() {
    return _firebaseFirestore
        .collection('penjualanBulanan')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PenjualanBulanan.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<PenjualanBulanan> getPenjualanBulananTerakhir() {
    return _firebaseFirestore
        .collection('penjualanBulanan')
        .orderBy('tanggal')
        .snapshots()
        .map((snapshot) {
      return PenjualanBulanan.fromSnapshot(snapshot.docs.last);
    });
  }

  Future<void> addPenjualanBulanan(PenjualanBulanan penjualanBulanan) {
    return _firebaseFirestore
        .collection('penjualanBulanan')
        .add(penjualanBulanan.toDocument());
  }

  Future<void> deletePenjualanBulanan(String id) {
    return _firebaseFirestore.collection('penjualanBulanan').doc(id).delete();
  }

  Future<void> updatePenjualanBulanan(
      PenjualanBulanan penjualanBulanan, String id) {
    return _firebaseFirestore.collection('penjualanBulanan').doc(id).update(
      {
        'tanggal': penjualanBulanan.tanggal,
        'jumlahPenjualan': penjualanBulanan.jumlahPenjualan,
      },
    );
  }

  Future<void> updateJumlahPenjualan(String id, int jumlahPenjualan) {
    return _firebaseFirestore.collection('penjualanBulanan').doc(id).update(
      {
        'jumlahPenjualan': jumlahPenjualan,
      },
    );
  }
}
