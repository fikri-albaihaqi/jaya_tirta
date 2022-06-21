import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Ramalan extends Equatable {
  final int? bulan;
  final double? hasilRamal;

  const Ramalan({
    required this.bulan,
    required this.hasilRamal,
  });

  static Ramalan fromSnapshot(DocumentSnapshot snap) {
    Ramalan peramalan = Ramalan(
      bulan: snap['bulan'],
      hasilRamal: snap['hasilRamal'],
    );
    return peramalan;
  }

  @override
  List<Object?> get props => [
        bulan,
        hasilRamal,
      ];

  Map<String, Object> toDocument() {
    return {
      'bulan': bulan!,
      'hasilRamal': hasilRamal!,
    };
  }
}
