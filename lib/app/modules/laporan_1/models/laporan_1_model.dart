// To parse this JSON data, do
//
//     final modelLaporan1 = modelLaporan1FromJson(jsonString);

import 'dart:convert';

ModelLaporan1 modelLaporan1FromJson(String str) =>
    ModelLaporan1.fromJson(json.decode(str));

String modelLaporan1ToJson(ModelLaporan1 data) => json.encode(data.toJson());

class ModelLaporan1 {
  String jenisPajak;
  String qris;
  String va;

  ModelLaporan1({
    required this.jenisPajak,
    required this.qris,
    required this.va,
  });

  factory ModelLaporan1.fromJson(Map<String, dynamic> json) => ModelLaporan1(
        jenisPajak: json["JENIS_PAJAK"],
        qris: json["QRIS"],
        va: json["VA"],
      );

  Map<String, dynamic> toJson() => {
        "JENIS_PAJAK": jenisPajak,
        "QRIS": qris,
        "VA": va,
      };
}
