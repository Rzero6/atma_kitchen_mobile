import 'dart:async';
import 'dart:convert';
import 'package:atma_kitchen_mobile/api/api_client.dart';
import 'package:atma_kitchen_mobile/model/hampers.dart';
import 'package:http/http.dart' as http;

class HampersClient {
  static final ApiClient apiClient = ApiClient();
  static const String timeout = 'Take too long, check your connection';
  static Future<List<Hampers>> getAllHampers() async {
    var client = http.Client();
    Uri uri;

    try {
      uri = Uri.parse('${apiClient.baseUrl}/hampers');
      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        throw json.decode(response.body)['message'].toString();
      }
      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Hampers.fromJson(e)).toList();
    } on TimeoutException catch (_) {
      return Future.error(timeout);
    } catch (e) {
      return Future.error(e.toString());
    } finally {
      client.close();
    }
  }
}
