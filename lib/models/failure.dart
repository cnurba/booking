// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int code;
  final String message;
  const Failure({
    required this.code,
    required this.message,
  });

  factory Failure.noFailure() => const Failure(code: 0, message: "");

  Failure copyWith({
    int? code,
    String? message,
  }) {
    return Failure(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, message];
}
