import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:server_todo/models/company.dart';
import 'package:server_todo/models/failure.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = context.read<Connection>();

  await _createTable(connection);

  return switch (context.request.method) {
    HttpMethod.get => _getLists(context),
    HttpMethod.post => _createList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<(Failure, bool)> _createTable(Connection connection) async {
  try {
    await connection.execute('CREATE TABLE IF NOT EXISTS companies ('
        '  id SERIAL PRIMARY KEY, '
        '  companyId VARCHAR(40), '
        '  companyName VARCHAR(255)'
        ')');

    return (Failure(code: 1, message: ""), true);
  } catch (e) {
    return const (
      Failure(code: 1, message: 'Ошибка при создании таблицы организации'),
      true
    );
  }
}

Future<Response> _createList(RequestContext context) async {
  final listBody = await context.request.json() as List<dynamic>;

  final connection = context.read<Connection>();

  try {
    String companyId = "";

    for (final data in listBody) {
      companyId = data["companyId"].toString();
    }

    if (companyId != "") {
      await connection.execute(
        r'Delete from companies Where companyId = $1',
        parameters: [companyId],
      );
    }

    for (final data in listBody) {
      final company = Company.fromMap(data as Map<String, dynamic>);
      await connection.execute(
        r'INSERT INTO companies (companyId,companyName) VALUES ($1,$2)',
        parameters: [company.companyId, company.companyName],
      );
    }

    return Response.json(body: companyId); //{'success': true});
  } catch (e) {
    return Response(
        statusCode: HttpStatus.connectionClosedWithoutResponse,
        body: e.toString());
  }
}

Future<Response> _getLists(RequestContext context) async {
  final lists = <Map<String, dynamic>>[];
  final results = await context
      .read<Connection>()
      .execute('SELECT companyId , companyName FROM companies');

  for (final row in results) {
    lists.add({'companyId': row[0], 'companyName': row[1]});
  }

  return Response.json(body: lists.toString());
}
