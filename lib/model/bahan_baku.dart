class BahanBaku {
  int id;
  String nama;
  int stok;
  String satuan;
  bool packaging;

  BahanBaku({
    required this.id,
    required this.nama,
    required this.stok,
    required this.satuan,
    required this.packaging,
  });

  factory BahanBaku.fromJson(Map<String, dynamic> json) {
    return BahanBaku(
        id: json['id'],
        nama: json['nama'],
        stok: json['stok'],
        satuan: json['satuan'],
        packaging: json['packaging'] == 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'stok': stok,
    };
  }
}
