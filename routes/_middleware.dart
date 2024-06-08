import 'package:dart_frog/dart_frog.dart';
import 'package:server_todo/middleware/connection_middleware.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(connectionMiddleware);
  // .use(companyMiddleware);
}
