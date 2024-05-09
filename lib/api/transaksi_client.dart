import 'dart:async';
import 'dart:convert';
import 'package:atma_kitchen_mobile/model/transaksi.dart';
import 'package:atma_kitchen_mobile/api/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiClient {
  static final ApiClient apiClient = ApiClient();
  static const String timeout = 'Take too long, check your connection';

  static Future<List<Transaksi>> getTransaksisPerUser() async {
    var client = http.Client();
    Uri uri;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    int id = prefs.getInt('userID')!;

    try {
      uri = Uri.parse('${apiClient.baseUrl}/customer/$id/transaksi/');
      var response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        throw json.decode(response.body)['message'].toString();
      }
      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Transaksi.fromJson(e)).toList();
    } on TimeoutException catch (_) {
      return Future.error(timeout);
    } catch (e) {
      return Future.error(e.toString());
    } finally {
      client.close();
    }
  }
}
