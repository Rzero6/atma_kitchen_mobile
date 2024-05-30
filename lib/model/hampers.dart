import 'package:atma_kitchen_mobile/model/detail_hampers.dart';

class Hampers {
  int? id;
  String nama;
  double harga;
  String? image;
  List<DetailHampers>? detailHampers;

  Hampers({
    this.id,
    required this.nama,
    required this.harga,
    required this.image,
    this.detailHampers,
  });

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      id: json['id'],
      nama: json['nama'],
      harga: (json['harga'] as int).toDouble(),
      image: json['image'],
      detailHampers: (json['detailhampers'] as List)
          .map((detailJson) => DetailHampers.fromJson(detailJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
    };
  }
}
