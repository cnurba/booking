// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BuildingModel extends Equatable {
  final String buildingId;
  final String companyId;
  final String buildingName;
  const BuildingModel({
    required this.buildingId,
    required this.companyId,
    required this.buildingName,
  });

  BuildingModel copyWith({
    String? buildingId,
    String? companyId,
    String? buildingName,
  }) {
    return BuildingModel(
      buildingId: buildingId ?? this.buildingId,
      companyId: companyId ?? this.companyId,
      buildingName: buildingName ?? this.buildingName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buildingId': buildingId,
      'companyId': companyId,
      'buildingName': buildingName,
    };
  }

  factory BuildingModel.fromMap(Map<String, dynamic> map) {
    return BuildingModel(
      buildingId: map['buildingId'] as String,
      companyId: map['companyId'] as String,
      buildingName: map['buildingName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuildingModel.fromJson(String source) =>
      BuildingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [buildingId, companyId, buildingName];
}
