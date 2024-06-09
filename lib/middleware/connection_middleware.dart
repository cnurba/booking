import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

///
Handler connectionMiddleware(Handler handler) {
  return (context) async {
    final _endpoint = Endpoint(
      host: 'localhost',
      database: 'booking',
      port: 5432,
      password: "7861",
      username: "postgres",
    );

    final _connectionSettings = ConnectionSettings(sslMode: SslMode.disable);

    final connection =
        await Connection.open(_endpoint, settings: _connectionSettings);
    final response = await handler
        .use(provider<Connection>((_) => connection))
        .call(context);

    await connection.close();

    return response;
  };
}
