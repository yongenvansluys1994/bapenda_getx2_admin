// To parse this JSON data, do
//
//     final modelLaporan2 = modelLaporan2FromJson(jsonString);

import 'dart:convert';

ModelLaporan2 modelLaporan2FromJson(String str) =>
    ModelLaporan2.fromJson(json.decode(str));

String modelLaporan2ToJson(ModelLaporan2 data) => json.encode(data.toJson());

class ModelLaporan2 {
  String tglPenetapan;
  String batasBayar;
  String kodeRekening;
  String namaRekening;
  String nomorKohir;
  String namaWp;
  String npwpd;
  int jumlahPajak;
  int denda;
  int telahDibayar;
  String masaPajak;
  String uraianH2H;

  ModelLaporan2({
    required this.tglPenetapan,
    required this.batasBayar,
    required this.kodeRekening,
    required this.namaRekening,
    required this.nomorKohir,
    required this.namaWp,
    required this.npwpd,
    required this.jumlahPajak,
    required this.denda,
    required this.telahDibayar,
    required this.masaPajak,
    required this.uraianH2H,
  });

  factory ModelLaporan2.fromJson(Map<String, dynamic> json) => ModelLaporan2(
        tglPenetapan: json["TGL_PENETAPAN"],
        batasBayar: json["BATAS_BAYAR"],
        kodeRekening: json["KODE_REKENING"],
        namaRekening: json["NAMA_REKENING"],
        nomorKohir: json["NOMOR_KOHIR"],
        namaWp: json["NAMA_WP"],
        npwpd: json["NPWPD"],
        jumlahPajak: json["JUMLAH_PAJAK"],
        denda: json["DENDA"],
        telahDibayar: json["TELAH_DIBAYAR"],
        masaPajak: json["MASA_PAJAK"],
        uraianH2H: json["URAIAN_H2H"],
      );

  Map<String, dynamic> toJson() => {
        "TGL_PENETAPAN": tglPenetapan,
        "BATAS_BAYAR": batasBayar,
        "KODE_REKENING": kodeRekening,
        "NAMA_REKENING": namaRekening,
        "NOMOR_KOHIR": nomorKohir,
        "NAMA_WP": namaWp,
        "NPWPD": npwpd,
        "JUMLAH_PAJAK": jumlahPajak,
        "DENDA": denda,
        "TELAH_DIBAYAR": telahDibayar,
        "MASA_PAJAK": masaPajak,
        "URAIAN_H2H": uraianH2H,
      };
}
