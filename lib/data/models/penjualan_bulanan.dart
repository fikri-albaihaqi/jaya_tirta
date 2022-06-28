import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PenjualanBulanan extends Equatable {
  final String? id;
  final String? tanggal;
  final int? jumlahPenjualan;

  const PenjualanBulanan(
      {required this.id, required this.tanggal, required this.jumlahPenjualan});

  static PenjualanBulanan fromSnapshot(DocumentSnapshot snap) {
    PenjualanBulanan penjual = PenjualanBulanan(
      id: snap.id,
      tanggal: snap['tanggal'],
      jumlahPenjualan: snap['jumlahPenjualan'],
    );
    return penjual;
  }

  @override
  List<Object?> get props => [
        id,
        tanggal,
        jumlahPenjualan,
      ];

  Map<String, Object> toDocument() {
    return {
      'tanggal': tanggal!,
      'jumlahPenjualan': jumlahPenjualan!,
    };
  }
}
