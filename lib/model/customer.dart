import 'package:atma_kitchen_mobile/model/user.dart';

class Customer {
  int? id;
  int? idUser;
  String tanggalLahir;
  int promoPoin;
  int saldo;
  String? profilPic;
  User? user;
  Customer(
      {this.id,
      this.idUser,
      required this.tanggalLahir,
      required this.promoPoin,
      required this.saldo,
      this.profilPic,
      this.user});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      idUser: json['id_user'],
      tanggalLahir: json['tanggal_lahir'],
      promoPoin: json['promo_poin'],
      saldo: json['saldo'],
      profilPic: json['profil_pic'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'tanggal_lahir': tanggalLahir,
      'promo_poin': promoPoin,
      'saldo': saldo,
    };
  }
}
