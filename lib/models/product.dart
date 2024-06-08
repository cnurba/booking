// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String productId;
  final String productName;
  final String articul;
  final String unit;
  final bool isService;
  final String companyId;
  const Product({
    required this.productId,
    required this.productName,
    required this.articul,
    required this.unit,
    required this.isService,
    required this.companyId,
  });

  Product copyWith({
    String? productId,
    String? productName,
    String? articul,
    String? unit,
    bool? isService,
    String? companyId,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      articul: articul ?? this.articul,
      unit: unit ?? this.unit,
      isService: isService ?? this.isService,
      companyId: companyId ?? this.companyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'articul': articul,
      'unit': unit,
      'isService': isService,
      'companyId': companyId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      articul: map['articul'] as String,
      unit: map['unit'] as String,
      isService: map['isService'] as bool,
      companyId: map['companyId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      productId,
      productName,
      articul,
      unit,
      isService,
      companyId,
    ];
  }
}
