import 'package:atma_kitchen_mobile/model/user.dart';

class Presensi {
  int? id;
  int? idKaryawan;
  String tanggal;
  bool kehadiran;
  bool kehadiranOri;
  User user;
  String role;
  Presensi({
    this.id,
    this.idKaryawan,
    required this.tanggal,
    required this.kehadiran,
    required this.kehadiranOri,
    required this.user,
    required this.role,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      id: json['id'],
      idKaryawan: json['id_karyawan'],
      tanggal: json['tanggal'],
      kehadiran: (json['kehadiran'] as int) == 1,
      kehadiranOri: (json['kehadiran'] as int) == 1,
      user: User.fromJson(json['karyawan']['user']),
      role: json['karyawan']['user']['role'] != null
          ? json['karyawan']['user']['role']['nama']
          : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_karyawan': idKaryawan,
      'tanggal': tanggal,
      'kehadiran': kehadiran,
    };
  }
}
