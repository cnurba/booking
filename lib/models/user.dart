// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String fullName;
  final String companyId;
  final String companyName;
  final String username;
  final String password;

  final bool allowCreateProduct;
  final bool allowCreateContract;
  final bool allowCreateClient;
  final bool allowTextInsteadOfProduct;
  final int limited;
  const User({
    required this.userId,
    required this.fullName,
    required this.companyId,
    required this.companyName,
    required this.username,
    required this.password,
    required this.allowCreateProduct,
    required this.allowCreateContract,
    required this.allowCreateClient,
    required this.allowTextInsteadOfProduct,
    required this.limited,
  });

  User copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? companyId,
    String? companyName,
    String? username,
    String? password,
    bool? allowCreateProduct,
    bool? allowCreateContract,
    bool? allowCreateClient,
    bool? allowTextInsteadOfProduct,
    int? limit,
  }) {
    return User(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      username: username ?? this.username,
      password: password ?? this.password,
      allowCreateProduct: allowCreateProduct ?? this.allowCreateProduct,
      allowCreateContract: allowCreateContract ?? this.allowCreateContract,
      allowCreateClient: allowCreateClient ?? this.allowCreateClient,
      allowTextInsteadOfProduct:
          allowTextInsteadOfProduct ?? this.allowTextInsteadOfProduct,
      limited: limit ?? this.limited,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fullName': fullName,
      'companyId': companyId,
      'companyName': companyName,
      'username': username,
      'password': password,
      'allowCreateProduct': allowCreateProduct,
      'allowCreateContract': allowCreateContract,
      'allowCreateClient': allowCreateClient,
      'allowTextInsteadOfProduct': allowTextInsteadOfProduct,
      'limited': limited,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      fullName: map['fullName'] as String,
      companyId: map['companyId'] as String,
      companyName: map['companyName'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      allowCreateProduct: map['allowCreateProduct'] as bool,
      allowCreateContract: map['allowCreateContract'] as bool,
      allowCreateClient: map['allowCreateClient'] as bool,
      allowTextInsteadOfProduct: map['allowTextInsteadOfProduct'] as bool,
      limited: map['limited'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      userId,
      fullName,
      companyId,
      companyName,
      username,
      password,
      allowCreateProduct,
      allowCreateContract,
      allowCreateClient,
      allowTextInsteadOfProduct,
      limited,
    ];
  }
}
