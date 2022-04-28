import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Konsumen extends Equatable {
  String? _id = '';
  String? get id => _id;
  set id(String? value) {
    _id = value;
  }

  final String? nama;
  final String? alamat;
  final String? noTelp;

  Konsumen({
    required this.nama,
    required this.alamat,
    required this.noTelp,
  });

  static Konsumen fromSnapshot(DocumentSnapshot snap) {
    Konsumen konsumen = Konsumen(
      nama: snap['nama'],
      alamat: snap['alamat'],
      noTelp: snap['noTelp'],
    );
    return konsumen;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw [
        nama,
        alamat,
        noTelp,
      ];

  Map<String, Object> toDocument() {
    return {
      'nama': nama!,
      'alamat': alamat!,
      'noTelp': noTelp!,
    };
  }
}
