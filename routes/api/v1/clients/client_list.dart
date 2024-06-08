import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _getLists(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _getLists(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;

  final companyId = body['companyId'] as String;

  final lists = <Map<String, dynamic>>[];
  final results = await context.read<Connection>().execute(
    r'SELECT companyId , clientId, clientName, inn FROM clients Where companyId = $1',
    parameters: [companyId],
  );

  for (final row in results) {
    lists.add({
      'companyId': row[0],
      'clientId': row[1],
      'clientName': row[2],
      'inn': row[3]
    });
  }

  return Response.json(body: lists.toString());
}
