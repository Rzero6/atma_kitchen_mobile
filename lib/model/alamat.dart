class Alamat {
  int? id;
  int? idCustomer;
  String namaPenerima;
  String noTelp;
  String kota;
  String jalan;
  String rincian;

  Alamat({
    this.id,
    this.idCustomer,
    required this.namaPenerima,
    required this.noTelp,
    required this.kota,
    required this.jalan,
    required this.rincian,
  });

  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      id: json['id'],
      idCustomer: json['id_customer'],
      namaPenerima: json['nama_penerima'],
      noTelp: json['no_telepon'],
      jalan: json['jalan'],
      kota: json['kota'],
      rincian: json['rincian'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_customer': idCustomer,
      'nama_penerima': namaPenerima,
      'no_telepon': noTelp,
      'jalan': jalan,
      'kota': kota,
      'rincian': rincian,
    };
  }
}
