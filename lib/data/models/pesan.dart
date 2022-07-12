import 'dart:convert';

import 'package:equatable/equatable.dart';

class Pesan extends Equatable {
  final String obrolanId;
  final String senderUID;
  final String receiverUID;
  final String content;
  final String timeStamp;

  const Pesan({
    required this.obrolanId,
    required this.senderUID,
    required this.receiverUID,
    required this.content,
    required this.timeStamp,
  });

  Pesan copyWith({
    String? obrolanId,
    String? senderUID,
    String? receiverUID,
    String? content,
    String? timeStamp,
  }) {
    return Pesan(
      obrolanId: obrolanId ?? this.obrolanId,
      senderUID: senderUID ?? this.senderUID,
      receiverUID: receiverUID ?? this.receiverUID,
      content: content ?? this.content,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'obrolanId': obrolanId,
      'senderUID': senderUID,
      'receiverUID': receiverUID,
      'content': content,
      'timestamp': timeStamp,
    };
  }

  factory Pesan.fromMap(Map<String, dynamic> map) {
    return Pesan(
      obrolanId: map['obrolanId']?.toString() ?? '',
      senderUID: map['senderUID']?.toString() ?? '',
      receiverUID: map['receiverUID']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      timeStamp: map['timestamp']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Pesan.fromJson(String source) =>
      Pesan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pesan(obrolanId: $obrolanId, senderUID: $senderUID, receiverUID: $receiverUID, content: $content, timeStamp: $timeStamp)';
  }

  @override
  List<Object> get props {
    return [
      obrolanId,
      senderUID,
      receiverUID,
      content,
      timeStamp,
    ];
  }
}
