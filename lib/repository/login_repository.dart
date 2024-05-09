import 'package:atma_kitchen_mobile/api/auth_client.dart';

import '../model/user.dart';

class FailedLogin implements Exception {
  String errorMessage() {
    return "Login Failed";
  }
}

class LoginRepository {
  AuthClient authClient = AuthClient();

  Future<User> login(String email, String password) async {
    try {
      User userData = await authClient.loginUser(email, password);
      return userData;
    } catch (e) {
      rethrow;
    }
  }
}
