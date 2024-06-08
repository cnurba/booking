import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _getProductListByCompanyId(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _getProductListByCompanyId(RequestContext context) async {
  final lists = <Map<String, dynamic>>[];

  final body = await context.request.json() as Map<String, dynamic>;

  final companyId = body['companyId'] as String;

  final results = await context.read<Connection>().execute(
    r'SELECT productId , productName, unit, isService, companyId FROM products Where companyId = $1',
    parameters: [companyId],
  );

  for (final row in results) {
    lists.add({
      'productId': row[0],
      'productName': row[1],
      'unit': row[2],
      'isService': row[3],
      'companyId': row[3]
    });
  }

  return Response.json(body: lists.toString());
}
