// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ClientModel extends Equatable {
  final String clientId;
  final String clientName;
  final String inn;
  final String companyId;
  const ClientModel({
    required this.clientId,
    required this.clientName,
    required this.inn,
    required this.companyId,
  });

  ClientModel copyWith({
    String? clientId,
    String? clientName,
    String? inn,
    String? companyId,
  }) {
    return ClientModel(
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      inn: inn ?? this.inn,
      companyId: companyId ?? this.companyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientId': clientId,
      'clientName': clientName,
      'inn': inn,
      'companyId': companyId,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      clientId: map['clientId'] as String,
      clientName: map['clientName'] as String,
      inn: map['inn'] as String,
      companyId: map['companyId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [clientId, clientName, inn, companyId];
}
