class ApiClient {
  final String domainName = 'http://10.0.2.2:8000';
  late final String baseUrl;
  late final String pic;
  late final String produk;
  late final String hampers;
  late final String transfer;
  ApiClient() {
    baseUrl = '$domainName/api';
    pic = '$domainName/storage/customer/';
    produk = '$domainName/storage/produk/';
    hampers = '$domainName/storage/hampers/';
    transfer = '$domainName/storage/bukti_transfer/';
  }
}
