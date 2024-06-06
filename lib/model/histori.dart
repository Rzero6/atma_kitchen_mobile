import 'dart:convert';

class HistoriSaldo {
  int? id;
  int? idCustomer;
  double mutasi;
  bool status;
  String tujuan;
  String? buktiTransfer;
  String? updateAt;

  HistoriSaldo({
    this.id,
    this.idCustomer,
    required this.mutasi,
    required this.status,
    required this.tujuan,
    this.buktiTransfer,
    this.updateAt,
  });

  factory HistoriSaldo.fromJson(Map<String, dynamic> json) {
    return HistoriSaldo(
      id: json['id'],
      idCustomer: json['id_customer'],
      mutasi: (json['mutasi'] as int).toDouble(),
      status: json['status'] == 1,
      tujuan: json['tujuan'],
      buktiTransfer: json['bukti_transfer'] ?? "",
      updateAt: json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_customer': idCustomer,
      'mutasi': mutasi,
      'tujuan': tujuan,
    };
  }
}
