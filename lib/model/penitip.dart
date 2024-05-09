class Penitip {
  int? id;
  String nama;
  String noTelp;

  Penitip({
    this.id,
    required this.nama,
    required this.noTelp,
  });

  factory Penitip.fromJson(Map<String, dynamic> json) {
    return Penitip(
      id: json['id'],
      nama: json['nama'],
      noTelp: json['no_telp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'no_telp': noTelp,
    };
  }
}
