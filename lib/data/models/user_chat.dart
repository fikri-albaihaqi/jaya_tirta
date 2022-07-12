import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserChat extends Equatable {
  final String uid;
  final String nama;

  const UserChat({
    required this.uid,
    required this.nama,
  });

  UserChat copyWith({
    String? uid,
    String? displayName,
  }) {
    return UserChat(
      uid: uid ?? this.uid,
      nama: displayName ?? this.nama,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': nama,
    };
  }

  factory UserChat.fromMap(Map<String, dynamic> map) {
    return UserChat(
      uid: map['uid']?.toString() ?? '',
      nama: map['displayName']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChat.fromJson(String source) =>
      UserChat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(uid: $uid, displayName: $nama)';
  }

  @override
  List<Object> get props => [uid, nama];
}
