import 'package:server_todo/models/user.dart';

Map<String, User> userDb = {};

class UserRepository {
  Future<User?> userFromCredentials(String username, String password) async {
    //final hashedPassword = password.hashvalue;

    final Iterable<User> users = userDb.values.where(
      (user) => user.username == username && user.password == password,
    );

    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  User? userFromId(String id) {
    return userDb[id];
  }
}
