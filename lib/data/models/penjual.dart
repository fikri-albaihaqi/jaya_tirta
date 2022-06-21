import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Penjual extends Equatable {
  final String? id;
  final String? nama;
  final String? noTelp;

  const Penjual({
    required this.id,
    required this.nama,
    required this.noTelp,
  });

  static Penjual fromSnapshot(DocumentSnapshot snap) {
    Penjual penjual = Penjual(
      id: snap.id,
      nama: snap['nama'],
      noTelp: snap['noTelp'],
    );
    return penjual;
  }

  @override
  List<Object?> get props => [
        id,
        nama,
        noTelp,
      ];

  Map<String, Object> toDocument() {
    return {
      'id': id!,
      'nama': nama!,
      'noTelp': noTelp!,
    };
  }
}
