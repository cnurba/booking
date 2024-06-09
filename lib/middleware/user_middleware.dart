import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:server_todo/models/user.dart';
import 'package:server_todo/repositories/user/user_repository.dart';

///
Handler userMiddleware(Handler handler) {
  return handler.use(provider<UserRepository>((_) => UserRepository())).use(
        basicAuthentication<User>(
          authenticator: (context, username, password) {
            final repository = context.read<UserRepository>();

            return repository.userFromCredentials(username, password);
          },
          applies: (RequestContext context) async {
            return context.request.method != HttpMethod.post;
          },
        ),
      );
}
