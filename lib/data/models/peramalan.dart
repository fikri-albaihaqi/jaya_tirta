import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Peramalan extends Equatable {
  final int? bulanKe;
  final double? hasilRamal;

  const Peramalan({
    required this.bulanKe,
    required this.hasilRamal,
  });

  static Peramalan fromSnapshot(DocumentSnapshot snap) {
    Peramalan peramalan = Peramalan(
      bulanKe: snap['bulanKe'],
      hasilRamal: snap['hasilRamal'],
    );
    return peramalan;
  }

  @override
  List<Object?> get props => [
        bulanKe,
        hasilRamal,
      ];

  Map<String, Object> toDocument() {
    return {
      'bulanKe': bulanKe!,
      'hasilRamal': hasilRamal!,
    };
  }
}
