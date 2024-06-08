import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getUserww(context),
    HttpMethod.post => _getUser(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _getUserww(RequestContext context) async {
  return Response(body: "Сервер работает");
}

Future<Response> _getUser(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;

  final username = body['username'] as String;
  final password = body['password'] as String;

  final results = await context.read<Connection>().execute(
    r'SELECT userId,fullName, companyId,companyName,allowCreateProduct,allowCreateContract,allowCreateClient,allowTextInsteadOfProduct,limited FROM users Where username = $1 ANd password=$2 ',
    parameters: [username, password],
  );

  if (results.isEmpty) {
    return Response(statusCode: HttpStatus.notFound);
  }
  final row = results.first;

  final res = {
    'userId': row[0],
    'fullName': row[1],
    'companyId': row[2],
    'companyName': row[3],
    'allowCreateProduct': row[4],
    'allowCreateContract': row[5],
    'allowCreateClient': row[6],
    'allowTextInsteadOfProduct': row[7],
    'limited': row[8],
  };

  return Response.json(body: res.toString());
}
