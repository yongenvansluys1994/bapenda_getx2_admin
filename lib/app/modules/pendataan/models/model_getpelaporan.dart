// To parse this JSON data, do
//
//     final modelGetpelaporan = modelGetpelaporanFromJson(jsonString);

import 'dart:convert';

ModelGetpelaporan modelGetpelaporanFromJson(String str) =>
    ModelGetpelaporan.fromJson(json.decode(str));

String modelGetpelaporanToJson(ModelGetpelaporan data) =>
    json.encode(data.toJson());

class ModelGetpelaporan {
  String idDaftarwp;
  String idWajibPajak;
  String idPelaporan;
  String idSpt;
  String nomorKohir;
  String nikUser;
  String npwpd;
  String namaUsaha;
  String alamatUsaha;
  String jenispajak;
  String namaPemilik;
  String masaPajak;
  String masaPajak2;
  String masaAkhir2;
  String pendapatan;
  String bukti;
  DateTime date;
  String pajak;
  String tarifPersen;
  String kodeRekening;
  String namaRekening;
  String status;
  String tanggalLunas;
  String nomorSpt;
  String idRekening;

  ModelGetpelaporan({
    required this.idDaftarwp,
    required this.idWajibPajak,
    required this.idPelaporan,
    required this.idSpt,
    required this.nomorKohir,
    required this.nikUser,
    required this.npwpd,
    required this.namaUsaha,
    required this.alamatUsaha,
    required this.jenispajak,
    required this.namaPemilik,
    required this.masaPajak,
    required this.masaPajak2,
    required this.masaAkhir2,
    required this.pendapatan,
    required this.bukti,
    required this.date,
    required this.pajak,
    required this.tarifPersen,
    required this.kodeRekening,
    required this.namaRekening,
    required this.status,
    required this.tanggalLunas,
    required this.nomorSpt,
    required this.idRekening,
  });

  factory ModelGetpelaporan.fromJson(Map<String, dynamic> json) =>
      ModelGetpelaporan(
        idDaftarwp: json["ID_DAFTARWP"],
        idWajibPajak: json["ID_WAJIB_PAJAK"],
        idPelaporan: json["ID_PELAPORAN"],
        idSpt: json["ID_SPT"],
        nomorKohir: json["NOMOR_KOHIR"],
        nikUser: json["NIK_USER"],
        npwpd: json["NPWPD"],
        namaUsaha: json["NAMA_USAHA"],
        alamatUsaha: json["ALAMAT_USAHA"],
        jenispajak: json["JENISPAJAK"],
        namaPemilik: json["NAMA_PEMILIK"],
        masaPajak: json["MASA_PAJAK"],
        masaPajak2: json["MASA_PAJAK2"],
        masaAkhir2: json["MASA_AKHIR2"],
        pendapatan: json["PENDAPATAN"],
        bukti: json["BUKTI"],
        date: DateTime.parse(json["DATE"]),
        pajak: json["PAJAK"],
        tarifPersen: json["TARIF_PERSEN"],
        kodeRekening: json["KODE_REKENING"],
        namaRekening: json["NAMA_REKENING"],
        status: json["STATUS"],
        tanggalLunas: json["TANGGAL_LUNAS"],
        nomorSpt: json["NOMOR_SPT"],
        idRekening: json["ID_REKENING"],
      );

  Map<String, dynamic> toJson() => {
        "ID_DAFTARWP": idDaftarwp,
        "ID_WAJIB_PAJAK": idWajibPajak,
        "ID_PELAPORAN": idPelaporan,
        "ID_SPT": idSpt,
        "NOMOR_KOHIR": nomorKohir,
        "NIK_USER": nikUser,
        "NPWPD": npwpd,
        "NAMA_USAHA": namaUsaha,
        "ALAMAT_USAHA": alamatUsaha,
        "JENISPAJAK": jenispajak,
        "NAMA_PEMILIK": namaPemilik,
        "MASA_PAJAK": masaPajak,
        "MASA_PAJAK2": masaPajak2,
        "MASA_AKHIR2": masaAkhir2,
        "PENDAPATAN": pendapatan,
        "BUKTI": bukti,
        "DATE":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "PAJAK": pajak,
        "TARIF_PERSEN": tarifPersen,
        "KODE_REKENING": kodeRekening,
        "NAMA_REKENING": namaRekening,
        "STATUS": status,
        "TANGGAL_LUNAS": tanggalLunas,
        "NOMOR_SPT": nomorSpt,
        "ID_REKENING": idRekening,
      };
}
