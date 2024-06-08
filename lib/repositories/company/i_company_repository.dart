import 'dart:core';
import 'package:server_todo/models/company.dart';
import 'package:server_todo/models/failure.dart';

///
abstract interface class ICompanyRepository {
  Future<(Failure, bool)> createTable();

  ///
  Future<(Failure, bool)> addAll(List<Company> companies);

  ///
  Future<(Failure, String)> getById(String uuid);
}
