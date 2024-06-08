import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:server_todo/models/contract.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = context.read<Connection>();

  final (r, b) = await _createTable(connection);
  if (b == false) {
    return r;
  }

  return switch (context.request.method) {
    HttpMethod.post => _createList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<(Response, bool)> _createTable(Connection connection) async {
  try {
    await connection.execute('CREATE TABLE IF NOT EXISTS contracts ('
        '  id SERIAL PRIMARY KEY, '
        '  companyId VARCHAR(40), '
        '  clientId VARCHAR(40), '
        '  clientName VARCHAR(240), '
        '  contractId VARCHAR(40), '
        '  contractName VARCHAR(180), '
        '  contractDate VARCHAR(180), '
        '  contractNumber VARCHAR(20)'
        ')');

    return (Response.json(body: {"success": true}), true);
  } catch (e) {
    return (
      Response.json(
          body: {"success": false}, statusCode: HttpStatus.badRequest),
      false
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
        r'Delete from contracts Where companyId = $1',
        parameters: [companyId],
      );
    }

    for (final data in listBody) {
      final contract = ContractModel.fromMap(data as Map<String, dynamic>);
      await connection.execute(
        r'INSERT INTO contracts (companyId,clientId, clientName, contractId,contractName,contractDate,contractNumber) VALUES ($1,$2,$3,$4,$5,$6,$7)',
        parameters: [
          contract.companyId,
          contract.clientId,
          contract.clientName,
          contract.contractId,
          contract.contractName,
          contract.contractDate,
          contract.contractNumber,
        ],
      );
    }
    return Response.json(body: {'success': true}); //;
  } catch (e) {
    return Response(
        statusCode: HttpStatus.connectionClosedWithoutResponse,
        body: e.toString());
  }
}
