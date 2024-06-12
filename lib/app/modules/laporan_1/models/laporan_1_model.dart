// To parse this JSON data, do
//
//     final modelLaporan1 = modelLaporan1FromJson(jsonString);

import 'dart:convert';

ModelLaporan1 modelLaporan1FromJson(String str) => ModelLaporan1.fromJson(json.decode(str));

String modelLaporan1ToJson(ModelLaporan1 data) => json.encode(data.toJson());

class ModelLaporan1 {
    String jenisPajak;
    int jumlahQris;
    String qris;
    int jumlahVa;
    String va;

    ModelLaporan1({
        required this.jenisPajak,
        required this.jumlahQris,
        required this.qris,
        required this.jumlahVa,
        required this.va,
    });

    factory ModelLaporan1.fromJson(Map<String, dynamic> json) => ModelLaporan1(
        jenisPajak: json["JENIS_PAJAK"],
        jumlahQris: json["JUMLAH_QRIS"],
        qris: json["QRIS"],
        jumlahVa: json["JUMLAH_VA"],
        va: json["VA"],
    );

    Map<String, dynamic> toJson() => {
        "JENIS_PAJAK": jenisPajak,
        "JUMLAH_QRIS": jumlahQris,
        "QRIS": qris,
        "JUMLAH_VA": jumlahVa,
        "VA": va,
    };
}
