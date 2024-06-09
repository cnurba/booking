// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:server_todo/hash_extantion.dart';

Map<String, Session> sessionDb = {};

class Session extends Equatable {
  ///
  final String token;
  final String userId;
  final DateTime expiryDate;
  final DateTime createdAt;

  const Session({
    required this.token,
    required this.userId,
    required this.expiryDate,
    required this.createdAt,
  });

  Session copyWith({
    String? token,
    String? userId,
    DateTime? expiryDate,
    DateTime? createdAt,
  }) {
    return Session(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      expiryDate: expiryDate ?? this.expiryDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'expiryDate': expiryDate.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      token: map['token'] as String,
      userId: map['userId'] as String,
      expiryDate: DateTime.fromMillisecondsSinceEpoch(map['expiryDate'] as int),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [token, userId, expiryDate, createdAt];
}

class SessionRepository {
  Session createSession(String userId) {
    final session = Session(
      token: generateToken(userId),
      userId: userId,
      expiryDate: DateTime.now().add(const Duration(hours: 24)),
      createdAt: DateTime.now(),
    );

    sessionDb[session.token] = session;
    return session;
  }

  /// generate token
  String generateToken(String userID) {
    return '${userID}_${DateTime.now().toIso8601String()}'.hashValue;
  }

  /// Search a session of a particular token

  Session? sessionFromToken(String token) {
    final session = sessionDb[token];
    if (session != null && session.expiryDate.isAfter(DateTime.now())) {
      return session;
    }
    return null;
  }
}
