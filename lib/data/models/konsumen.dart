import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Konsumen extends Equatable {
  final String? id;
  final String? nama;
  final String? alamat;
  final String? noTelp;
  final String? keckelurahan;
  final String? jumlahPinjaman;

  const Konsumen({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.noTelp,
    required this.keckelurahan,
    this.jumlahPinjaman,
  });

  static Konsumen fromSnapshot(DocumentSnapshot snap) {
    Konsumen konsumen = Konsumen(
      id: snap.id,
      nama: snap['nama'],
      alamat: snap['alamat'],
      noTelp: snap['noTelp'],
      keckelurahan: snap['keckelurahan'],
      jumlahPinjaman: snap['jumlahPinjaman'],
    );
    return konsumen;
  }

  @override
  List<Object?> get props => [
        id,
        nama,
        alamat,
        noTelp,
        keckelurahan,
        jumlahPinjaman,
      ];

  Map<String, Object> toDocument() {
    return {
      'id': id!,
      'nama': nama!,
      'alamat': alamat!,
      'noTelp': noTelp!,
      'keckelurahan': keckelurahan!,
      'jumlahPinjaman': jumlahPinjaman!,
    };
  }
}
