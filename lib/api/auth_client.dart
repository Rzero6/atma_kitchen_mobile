import 'package:atma_kitchen_mobile/model/customer.dart';
import 'package:atma_kitchen_mobile/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:atma_kitchen_mobile/api/api_client.dart';
import 'dart:async';
import 'dart:convert';

class AuthClient {
  ApiClient apiClient = ApiClient();

  Future<String> registerUser(User user, Customer customer) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/register');

    try {
      var response = await client.post(
        uri,
        body: {
          'nama': user.name,
          'email': user.email,
          'password': user.password,
          'no_telepon': user.phone,
          'tanggal_lahir': customer.tanggalLahir,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return 'Register Success';
      } else {
        var json = response.body;
        var jsonData = jsonDecode(json);
        if (jsonData.containsKey('message')) {
          var messageData = jsonData['message'];
          if (messageData.containsKey('email')) {
            var emailErrors = messageData['email'];
            if (emailErrors.isNotEmpty) {
              var errorMessage = emailErrors[0];
              throw (errorMessage);
            }
          }
        }
        throw (jsonData['message'] ?? 'Register Failed');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<User> loginUser(String email, String password) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/login');

    try {
      var response = await client.post(
        uri,
        body: {
          'email': email,
          'password': password,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var json = response.body;
        var jsonData = jsonDecode(json);

        var userJson = jsonData['user'];
        String token = jsonData['access_token'];
        User user = User.fromJson(userJson);
        user.token = token;
        return user;
      } else {
        var json = response.body;
        var jsonData = jsonDecode(json);
        throw (jsonData['message'] ?? 'Login Failed');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<String> requestResetPassword(String email) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/password/reset');

    try {
      var response = await client.post(
        uri,
        body: {
          'email': email,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['message'].toString();
      } else {
        final jsonData = jsonDecode(response.body);
        throw (
            jsonData['message'] ?? 'Reset gagal, silahkan kontak kami');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
