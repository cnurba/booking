// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String companyId;
  final String companyName;
  const Company({
    required this.companyId,
    required this.companyName,
  });

  Company copyWith({
    String? companyId,
    String? companyName,
  }) {
    return Company(
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'companyName': companyName,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      companyId: map['companyId'] as String,
      companyName: map['companyName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'companyId': companyId,
      'companyName': companyName,
    };
  }

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [companyId, companyName];
}
