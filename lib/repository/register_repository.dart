import 'package:atma_kitchen_mobile/model/customer.dart';
import 'package:atma_kitchen_mobile/model/user.dart';
import 'package:atma_kitchen_mobile/api/auth_client.dart';

class FailedRegister implements Exception {
  String errorMessage() {
    return "Register Failed";
  }
}

class RegisterRepository {
  AuthClient authClient = AuthClient();

  Future<User> register(String username, String password, String phone,
      String date, String email) async {
    User userData =
        User(name: username, password: password, phone: phone, email: email);
    Customer customerData =
        Customer(tanggalLahir: date, promoPoin: 0, saldo: 0);
    try {
      String message = await authClient.registerUser(userData, customerData);
      if (message == 'Register Success') {
        return userData;
      }
      userData.name = message;
      return userData;
    } catch (e) {
      rethrow;
    }
  }
}
