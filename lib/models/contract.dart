// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContractModel extends Equatable {
  final String clientId;
  final String clientName;
  final String companyId;
  final String contractId;
  final String contractName;
  final String contractDate;
  final String contractNumber;
  const ContractModel({
    required this.clientId,
    required this.clientName,
    required this.companyId,
    required this.contractId,
    required this.contractName,
    required this.contractDate,
    required this.contractNumber,
  });

  ContractModel copyWith({
    String? clientId,
    String? clientName,
    String? companyId,
    String? contractId,
    String? contractName,
    String? contractDate,
    String? contractNumber,
  }) {
    return ContractModel(
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      companyId: companyId ?? this.companyId,
      contractId: contractId ?? this.contractId,
      contractName: contractName ?? this.contractName,
      contractDate: contractDate ?? this.contractDate,
      contractNumber: contractNumber ?? this.contractNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientId': clientId,
      'clientName': clientName,
      'companyId': companyId,
      'contractId': contractId,
      'contractName': contractName,
      'contractDate': contractDate,
      'contractNumber': contractNumber,
    };
  }

  factory ContractModel.fromMap(Map<String, dynamic> map) {
    return ContractModel(
      clientId: map['clientId'] as String,
      clientName: map['clientName'] as String,
      companyId: map['companyId'] as String,
      contractId: map['contractId'] as String,
      contractName: map['contractName'] as String,
      contractDate: map['contractDate'] as String,
      contractNumber: map['contractNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContractModel.fromJson(String source) =>
      ContractModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      clientId,
      clientName,
      companyId,
      contractId,
      contractName,
      contractDate,
      contractNumber,
    ];
  }
}
