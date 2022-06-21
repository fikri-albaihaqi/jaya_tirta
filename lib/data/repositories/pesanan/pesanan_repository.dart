import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/models.dart';

class PesananRepository {
  final FirebaseFirestore _firebaseFirestore;

  PesananRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Pesanan>> getAllPesanan() {
    return _firebaseFirestore
        .collection('pesanan')
        .orderBy('tanggalPembelian')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Pesanan.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Pesanan>> getRiwayatPesanan() {
    return _firebaseFirestore
        .collection('pesanan')
        .where('status', isEqualTo: 'Pesanan Selesai')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((docs) => Pesanan.fromSnapshot(docs)).toList();
    });
  }

  Stream<List<Pesanan>> getPesananKonsumen(String id) {
    return _firebaseFirestore
        .collection('pesanan')
        .where('konsumen.idKonsumen', isEqualTo: id)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((docs) => Pesanan.fromSnapshot(docs)).toList();
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

  Future<void> updatePesanan(Pesanan pesanan, String id) {
    return _firebaseFirestore
        .collection('pesanan')
        .doc(id)
        .update(
          {
            'status': pesanan.status,
            'jumlah': pesanan.jumlah,
            'total': pesanan.total,
            'produk.idProduk': pesanan.idProduk,
            'produk.namaProduk': pesanan.namaProduk,
            'produk.gambar': pesanan.gambar,
            'produk.harga': pesanan.harga,
            'produk.stok': pesanan.stok,
            'konsumen.idKonsumen': pesanan.idKonsumen,
            'konsumen.namaKonsumen': pesanan.namaKonsumen,
            'konsumen.alamat': pesanan.alamat,
            'konsumen.noTelp': pesanan.noTelp,
            'konsumen.keckelurahan': pesanan.keckelurahan,
            'konsumen.jumlahPinjaman': pesanan.jumlahPinjaman,
          },
        )
        .then((_) => print(pesanan.status))
        .catchError((onError) => print('Update failed: $onError'));
  }
}
