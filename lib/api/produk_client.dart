import 'dart:async';
import 'dart:convert';
import 'package:atma_kitchen_mobile/api/api_client.dart';
import 'package:atma_kitchen_mobile/model/produk.dart';
import 'package:http/http.dart' as http;

class ProdukClient {
  static final ApiClient apiClient = ApiClient();
  static const String timeout = 'Take too long, check your connection';
  static Future<List<Produk>> getAllProduk() async {
    var client = http.Client();
    Uri uri;

    try {
      uri = Uri.parse('${apiClient.baseUrl}/produk');
      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        throw json.decode(response.body)['message'].toString();
      }
      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Produk.fromJson(e)).toList();
    } on TimeoutException catch (_) {
      return Future.error(timeout);
    } catch (e) {
      return Future.error(e.toString());
    } finally {
      client.close();
    }
  }
}
