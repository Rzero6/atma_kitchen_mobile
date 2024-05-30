import 'package:atma_kitchen_mobile/model/bahan_baku.dart';
import 'package:atma_kitchen_mobile/model/produk.dart';

class DetailHampers {
  int id;
  int? idProduk;
  int? idBahanBaku;
  int jumlah;
  Produk? produk;
  BahanBaku? bahanBaku;

  DetailHampers(
      {required this.id,
      this.idProduk,
      this.idBahanBaku,
      required this.jumlah,
      this.produk,
      this.bahanBaku});

  factory DetailHampers.fromJson(Map<String, dynamic> json) {
    return DetailHampers(
      id: json['id'],
      idProduk: json['id_produk'] ?? 0,
      idBahanBaku: json['id_bahan_baku'] ?? 0,
      jumlah: json['jumlah'],
      produk:
          json['id_produk'] == null ? null : Produk.fromJson(json['produk']),
      bahanBaku: json['id_bahan_baku'] == null
          ? null
          : BahanBaku.fromJson(json['bahan_baku']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_produk': idProduk,
      'id_bahan_baku': idBahanBaku,
      'jumlah': jumlah,
    };
  }
}
