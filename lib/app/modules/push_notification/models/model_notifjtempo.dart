// To parse this JSON data, do
//
//     final modelNotifJtempo = modelNotifJtempoFromJson(jsonString);

import 'dart:convert';

ModelNotifJtempo modelNotifJtempoFromJson(String str) =>
    ModelNotifJtempo.fromJson(json.decode(str));

String modelNotifJtempoToJson(ModelNotifJtempo data) =>
    json.encode(data.toJson());

class ModelNotifJtempo {
  String nomorSpt;
  String idWajibPajak;
  String nikUser;
  String nomorKohir;
  String idDaftarwp;
  String namaUsaha;
  String jatuhTempo;

  ModelNotifJtempo({
    required this.nomorSpt,
    required this.idWajibPajak,
    required this.nikUser,
    required this.nomorKohir,
    required this.idDaftarwp,
    required this.namaUsaha,
    required this.jatuhTempo,
  });

  factory ModelNotifJtempo.fromJson(Map<String, dynamic> json) =>
      ModelNotifJtempo(
        nomorSpt: json["NOMOR_SPT"],
        idWajibPajak: json["ID_WAJIB_PAJAK"],
        nikUser: json["NIK_USER"],
        nomorKohir: json["NOMOR_KOHIR"],
        idDaftarwp: json["ID_DAFTARWP"],
        namaUsaha: json["NAMA_USAHA"],
        jatuhTempo: json["JATUH_TEMPO"],
      );

  Map<String, dynamic> toJson() => {
        "NOMOR_SPT": nomorSpt,
        "ID_WAJIB_PAJAK": idWajibPajak,
        "NIK_USER": nikUser,
        "NOMOR_KOHIR": nomorKohir,
        "ID_DAFTARWP": idDaftarwp,
        "NAMA_USAHA": namaUsaha,
        "JATUH_TEMPO": jatuhTempo,
      };
}
