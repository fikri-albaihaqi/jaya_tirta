import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaya_tirta/data/models/produk.dart';
import 'package:path/path.dart' as path;

class ProdukRepository {
  final FirebaseFirestore _firebaseFirestore;
  FirebaseStorage storage = FirebaseStorage.instance;

  ProdukRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Produk>> getAllProduk() {
    return _firebaseFirestore.collection('produk').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Produk.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduk(Produk produk) {
    return _firebaseFirestore.collection('produk').add(produk.toDocument());
  }

  Future<void> deleteProduk(String id) {
    return _firebaseFirestore.collection('produk').doc(id).delete();
  }

  Future<void> updateProduk(Produk produk, String id) {
    return _firebaseFirestore.collection('produk').doc(id).update(
      {
        'namaProduk': produk.namaProduk,
        'gambar': produk.gambar,
        'stok': produk.stok,
        'harga': produk.harga,
      },
    );
  }

  Future<void> updateStok(String id, int stok) {
    return _firebaseFirestore.collection('produk').doc(id).update(
      {
        'stok': stok,
      },
    );
  }

  Future<String> uploadImage(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    pickedImage = await picker.pickImage(
        source:
            inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1920);

    final String fileName = path.basename(pickedImage!.path);
    File imageFile = File(pickedImage.path);

    UploadTask uploadTask = storage.ref(fileName).putFile(
        imageFile,
        SettableMetadata(
            customMetadata: {'uploaded_by': 'Admin', 'description': ''}));
    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }

  Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }
}
