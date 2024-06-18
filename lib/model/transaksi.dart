import 'dart:convert';

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
  double totalHarga;
  List<DetailTransaksi>? detailTransaksi;
  Transaksi({
    this.id,
    this.idAlamat,
    this.idCustomer,
    required this.tanggalPenerimaan,
    required this.status,
    required this.jarak,
    required this.tip,
    required this.totalHarga,
    this.alamat,
    this.detailTransaksi,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      idAlamat: json['id_alamat'],
      idCustomer: json['id_customer'],
      tanggalPenerimaan: json['tanggal_penerimaan'],
      status: json['status'],
      jarak: json['jarak'],
      tip: (json['tip'] as int).toDouble(),
      totalHarga: (json['total_harga'] as int).toDouble(),
      alamat:
          json['id_alamat'] != null ? Alamat.fromJson(json['alamat']) : null,
      detailTransaksi: (json['detail'] as List)
          .map((detailJson) => DetailTransaksi.fromJson(detailJson))
          .toList(),
    );
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
