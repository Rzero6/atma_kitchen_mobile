import 'package:atma_kitchen_mobile/model/penitip.dart';

class Produk {
  int? id;
  int? idPenitip;
  String nama;
  int stok;
  int limitPO;
  double harga;
  String jenis;
  String ukuran;
  String? image;
  Penitip? penitip;

  Produk({
    this.id,
    this.idPenitip,
    required this.nama,
    required this.stok,
    required this.harga,
    required this.limitPO,
    required this.jenis,
    required this.ukuran,
    this.image,
    this.penitip,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
        id: json['id'],
        idPenitip: json['id_penitip'],
        nama: json['nama'],
        stok: json['stok'],
        harga: json['harga'],
        limitPO: json['limit_po'],
        jenis: json['jenis'],
        ukuran: json['ukuran'],
        image: json['image'],
        penitip: Penitip.fromJson(json['penitip']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_penitip': idPenitip,
      'nama': nama,
      'stok': stok,
      'harga': harga,
      'limit_po': limitPO,
      'ukuran': ukuran,
      'jenis': jenis,
      'image': image,
    };
  }
}
