import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaya_tirta/data/models/models.dart';

class ObrolanRepository {
  final FirebaseFirestore firestore;
  ObrolanRepository({FirebaseFirestore? firebaseFirestore})
      : firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<Obrolan?> getObrolan({
    required String senderUID,
    required String receiverUID,
  }) async {
    final members = [senderUID, receiverUID];

    final obrolanQuerySnap = await firestore.collection('obrolan').where(
      'members',
      whereIn: [
        members,
        members.reversed.toList(),
      ],
    ).get();
    log(obrolanQuerySnap.docs.length.toString());
    if (obrolanQuerySnap.docs.isNotEmpty) {
      return Obrolan.fromMap(obrolanQuerySnap.docs.first.data());
    } else {
      return null;
    }
  }

  Future<String> createObrolan({
    required Obrolan obrolan,
  }) async {
    final obrolanRef =
        await firestore.collection('obrolan').add(obrolan.toMap());

    await obrolanRef.update({'id': obrolanRef.id});
    return obrolanRef.id;
  }
}
