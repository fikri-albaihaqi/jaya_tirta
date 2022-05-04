import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Konsumen extends Equatable {
  final String? id;
  final String? nama;
  final String? alamat;
  final String? noTelp;

  Konsumen({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.noTelp,
  });

  static Konsumen fromSnapshot(DocumentSnapshot snap) {
    Konsumen konsumen = Konsumen(
      id: snap['id'],
      nama: snap['nama'],
      alamat: snap['alamat'],
      noTelp: snap['noTelp'],
    );
    return konsumen;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw [
        id,
        nama,
        alamat,
        noTelp,
      ];

  Map<String, Object> toDocument() {
    return {
      'id': id!,
      'nama': nama!,
      'alamat': alamat!,
      'noTelp': noTelp!,
    };
  }
}
