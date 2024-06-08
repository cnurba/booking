import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:server_todo/models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = context.read<Connection>();

  final (f, b) = await _createTable(connection);

  if (b == false) {
    return f;
  }

  return switch (context.request.method) {
    HttpMethod.post => _createList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<(Response, bool)> _createTable(Connection connection) async {
  try {
    await connection.execute('CREATE TABLE IF NOT EXISTS users ('
        '  id SERIAL PRIMARY KEY, '
        '  userId VARCHAR(40), '
        '  companyId VARCHAR(40), '
        '  fullName VARCHAR(120), '
        '  companyName VARCHAR(120), '
        '  username VARCHAR(40), '
        '  password VARCHAR(10), '
        '  allowCreateProduct bool, '
        '  allowCreateContract bool, '
        '  allowCreateClient bool, '
        '  allowTextInsteadOfProduct bool, '
        '  limited int'
        ')');

    return (Response.json(body: {"Success": true}), true);
  } catch (e) {
    return (Response(body: e.toString()), false);
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
        r'Delete from users Where companyId = $1',
        parameters: [companyId],
      );
    }

    for (final data in listBody) {
      final user = User.fromMap(data as Map<String, dynamic>);
      await connection.execute(
        r'INSERT INTO users (userId,fullName,companyId,companyName,username,password,allowCreateProduct,allowCreateContract,allowCreateClient,allowTextInsteadOfProduct,limited) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)',
        parameters: [
          user.userId,
          user.fullName,
          user.companyId,
          user.companyName,
          user.username,
          user.password,
          user.allowCreateProduct,
          user.allowCreateContract,
          user.allowCreateClient,
          user.allowTextInsteadOfProduct,
          user.limited
        ],
      );
    }
    return Response.json(body: {'success': true}); //{'success': true});
  } catch (e) {
    return Response(
      statusCode: HttpStatus.connectionClosedWithoutResponse,
      body: {'success': false}.toString(),
    );
  }
}
