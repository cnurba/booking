import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:server_todo/models/product.dart';

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
    await connection.execute('CREATE TABLE IF NOT EXISTS products ('
        '  id SERIAL PRIMARY KEY, '
        '  companyId VARCHAR(40), '
        '  productId VARCHAR(40), '
        '  productName VARCHAR(180), '
        '  isService bool, '
        '  articul VARCHAR(180), '
        '  unit VARCHAR(40)'
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
        r'Delete from products Where companyId = $1',
        parameters: [companyId],
      );
    }

    for (final data in listBody) {
      final product = Product.fromMap(data as Map<String, dynamic>);
      await connection.execute(
        r'INSERT INTO products (companyId,articul, productId, productName,isService,unit) VALUES ($1,$2,$3,$4,$5,$6)',
        parameters: [
          product.companyId,
          product.articul,
          product.productId,
          product.productName,
          product.isService,
          product.unit,
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
