class DetailTransaksi {
  int? id;
  int? idTransaksi;
  int? idProduk;
  int? idHampers;
  int jumlah;

  DetailTransaksi(
      {this.id,
      this.idTransaksi,
      this.idProduk,
      this.idHampers,
      required this.jumlah});

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      id: json['id'],
      idTransaksi: json['id_transaksi'],
      idProduk: json['id_produk'],
      idHampers: json['id_hampers'],
      jumlah: json['jumlah'],
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
