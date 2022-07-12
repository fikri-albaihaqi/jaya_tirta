import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';

class Obrolan extends Equatable {
  final String? id;
  final UserChat? creator;
  final UserChat? receiver;
  final List<String> members;
  const Obrolan({
    this.id,
    this.creator,
    this.receiver,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator': creator!.toMap(),
      'receiver': receiver!.toMap(),
      'members': members,
    };
  }

  static Obrolan fromSnapshot(DocumentSnapshot snap) {
    Obrolan obrolan = Obrolan(
      id: snap['id'],
      creator: snap['creator'],
      receiver: snap['receiver'],
      members: snap['members'],
    );
    return obrolan;
  }

  factory Obrolan.fromMap(Map<String, dynamic> map) {
    return Obrolan(
      id: map['id']?.toString(),
      creator: UserChat.fromMap(map['creator'] as Map<String, dynamic>),
      receiver: UserChat.fromMap(
        map['receiver'] as Map<String, dynamic>,
      ),
      members: List<String>.from(map['members'] as List<dynamic>),
    );
  }

  @override
  List<Object?> get props => [
        id,
        creator,
        receiver,
        members,
      ];
}
