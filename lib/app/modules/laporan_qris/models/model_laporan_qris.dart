// To parse this JSON data, do
//
//     final modelLaporanQris = modelLaporanQrisFromJson(jsonString);

import 'dart:convert';

ModelLaporanQris modelLaporanQrisFromJson(String str) =>
    ModelLaporanQris.fromJson(json.decode(str));

String modelLaporanQrisToJson(ModelLaporanQris data) =>
    json.encode(data.toJson());

class ModelLaporanQris {
  String kdTagihan;
  String amount;
  String barcode;
  String namaUsaha;
  String jenispajak;
  String tanggalLunas;
  String pajak;
  String institusi;
  String trxDate;
  String rrn;

  ModelLaporanQris({
    required this.kdTagihan,
    required this.amount,
    required this.barcode,
    required this.namaUsaha,
    required this.jenispajak,
    required this.tanggalLunas,
    required this.pajak,
    required this.institusi,
    required this.trxDate,
    required this.rrn,
  });

  factory ModelLaporanQris.fromJson(Map<String, dynamic> json) =>
      ModelLaporanQris(
        kdTagihan: json["kd_tagihan"],
        amount: json["amount"],
        barcode: json["barcode"],
        namaUsaha: json["nama_usaha"],
        jenispajak: json["jenispajak"],
        tanggalLunas: json["tanggal_lunas"],
        pajak: json["pajak"],
        institusi: json["institusi"],
        trxDate: json["trx_date"],
        rrn: json["rrn"],
      );

  Map<String, dynamic> toJson() => {
        "kd_tagihan": kdTagihan,
        "amount": amount,
        "barcode": barcode,
        "nama_usaha": namaUsaha,
        "jenispajak": jenispajak,
        "tanggal_lunas": tanggalLunas,
        "pajak": pajak,
        "institusi": institusi,
        "trx_date": trxDate,
        "rrn": rrn,
      };
}
