import 'package:atma_kitchen_mobile/model/produk.dart';

class Hampers {
  int? id;
  int? idProduk1;
  int? idProduk2;
  String nama;
  String rincian;
  double harga;
  String? image;
  Produk? produk1;
  Produk? produk2;

  Hampers({
    this.id,
    this.idProduk1,
    this.idProduk2,
    required this.nama,
    required this.rincian,
    required this.harga,
    required this.image,
    this.produk1,
    this.produk2,
  });

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      id: json['id'],
      idProduk1: json['id_produk1'],
      idProduk2: json['id_produk2'],
      nama: json['nama'],
      rincian: json['rincian'],
      harga: json['harga'],
      image: json['image'],
      produk1: Produk.fromJson(json['produk1']),
      produk2: Produk.fromJson(json['produk2']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_produk1': idProduk1,
      'id_produk2': idProduk2,
      'nama': nama,
      'rincian': rincian,
      'harga': harga,
    };
  }
}
