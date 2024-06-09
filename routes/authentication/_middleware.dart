import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:server_todo/models/user.dart';
import 'package:server_todo/repositories/session/session_repository.dart';
import 'package:server_todo/repositories/user/user_repository.dart';

final sessionRepository = SessionRepository();
final userRepository = UserRepository();

///
Handler middleware(Handler handler) {
  return handler
      .use(provider<UserRepository>((_) => UserRepository()))
      .use(
        bearerAuthentication<User>(
          authenticator: (context, token) async {
            final sessionRepo = context.read<SessionRepository>();
            final userRepo = context.read<UserRepository>();

            final sesssion = await sessionRepo.sessionFromToken(token);
            return sesssion != null
                ? userRepo.userFromId(sesssion.userId)
                : null;
          },
          applies: (RequestContext context) async {
            return context.request.method != HttpMethod.post &&
                context.request.method != HttpMethod.get;
          },
        ),
      )
      .use(provider<UserRepository>((_) => userRepository))
      .use(provider<SessionRepository>((_) => sessionRepository));
}
