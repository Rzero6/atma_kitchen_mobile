import 'package:atma_kitchen_mobile/model/hampers.dart';
import 'package:atma_kitchen_mobile/model/produk.dart';

class DetailTransaksi {
  int? id;
  int? idTransaksi;
  int? idProduk;
  int? idHampers;
  int jumlah;
  Produk? produk;
  Hampers? hampers;

  DetailTransaksi({
    this.id,
    this.idTransaksi,
    this.idProduk,
    this.idHampers,
    required this.jumlah,
    this.produk,
    this.hampers,
  });

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      id: json['id'],
      idTransaksi: json['id_transaksi'],
      idProduk: json['id_produk'],
      idHampers: json['id_hampers'],
      jumlah: json['jumlah'],
      produk: json['produk'] != null ? Produk.fromJson(json['produk']) : null,
      hampers:
          json['hampers'] != null ? Hampers.fromJson(json['hampers']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_transaksi': idTransaksi,
      'id_produk': idProduk,
      'id_hampers': idHampers,
      'jumlah': jumlah,
    };
  }
}
