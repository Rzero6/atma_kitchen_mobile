import 'package:atma_kitchen_mobile/model/alamat.dart';
import 'package:atma_kitchen_mobile/model/detail_transaksi.dart';

class Transaksi {
  int? id;
  int? idAlamat;
  int? idCustomer;
  String tanggalPenerimaan;
  String status;
  int jarak;
  double tip;
  Alamat? alamat;
  List<DetailTransaksi>? detailTransaksi;
  Transaksi({
    this.id,
    this.idAlamat,
    this.idCustomer,
    required this.tanggalPenerimaan,
    required this.status,
    required this.jarak,
    required this.tip,
    this.alamat,
    this.detailTransaksi,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    List<dynamic>? jsonDetailTransaksi = json['detail_transaksi'];
    List<DetailTransaksi>? detailTransaksi;

    if (jsonDetailTransaksi != null) {
      detailTransaksi = jsonDetailTransaksi
          .map((detailJson) => DetailTransaksi.fromJson(detailJson))
          .toList();
    }

    return Transaksi(
        id: json['id'],
        idAlamat: json['id_alamat'],
        idCustomer: json['id_customer'],
        tanggalPenerimaan: json['tanggal_penerimaan'],
        status: json['status'],
        jarak: json['jarak'],
        tip: (json['tip'] as int).toDouble(),
        alamat: Alamat.fromJson(json['alamat']),
        detailTransaksi: detailTransaksi);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_alamat': idAlamat,
      'id_customer': idCustomer,
      'tanggal_penerimaan': tanggalPenerimaan,
      'status': status,
      'jarak': jarak,
      'tip': tip,
    };
  }
}
