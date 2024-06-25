// To parse this JSON data, do
//
//     final modelLapDaftarUser = modelLapDaftarUserFromJson(jsonString);

import 'dart:convert';

ModelLapDaftarUser modelLapDaftarUserFromJson(String str) => ModelLapDaftarUser.fromJson(json.decode(str));

String modelLapDaftarUserToJson(ModelLapDaftarUser data) => json.encode(data.toJson());

class ModelLapDaftarUser {
    String npwpd;
    String namaUsaha;
    String alamatUsaha;
    String rtUsaha;
    String nohpUsaha;
    String emailUsaha;
    String namaPemilik;
    String pekerjaanPemilik;
    String alamatPemilik;
    String rtPemilik;
    String nohpPemilik;
    String emailPemilik;
    String koordinat;
     String date;

    ModelLapDaftarUser({
        required this.npwpd,
        required this.namaUsaha,
        required this.alamatUsaha,
        required this.rtUsaha,
        required this.nohpUsaha,
        required this.emailUsaha,
        required this.namaPemilik,
        required this.pekerjaanPemilik,
        required this.alamatPemilik,
        required this.rtPemilik,
        required this.nohpPemilik,
        required this.emailPemilik,
        required this.koordinat,required this.date,
    });

    factory ModelLapDaftarUser.fromJson(Map<String, dynamic> json) => ModelLapDaftarUser(
        npwpd: json["npwpd"],
        namaUsaha: json["nama_usaha"],
        alamatUsaha: json["alamat_usaha"],
        rtUsaha: json["rt_usaha"],
        nohpUsaha: json["nohp_usaha"],
        emailUsaha: json["email_usaha"],
        namaPemilik: json["nama_pemilik"],
        pekerjaanPemilik: json["pekerjaan_pemilik"],
        alamatPemilik: json["alamat_pemilik"],
        rtPemilik: json["rt_pemilik"],
        nohpPemilik: json["nohp_pemilik"],
        emailPemilik: json["email_pemilik"],
        koordinat: json["koordinat"],date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "npwpd": npwpd,
        "nama_usaha": namaUsaha,
        "alamat_usaha": alamatUsaha,
        "rt_usaha": rtUsaha,
        "nohp_usaha": nohpUsaha,
        "email_usaha": emailUsaha,
        "nama_pemilik": namaPemilik,
        "pekerjaan_pemilik": pekerjaanPemilik,
        "alamat_pemilik": alamatPemilik,
        "rt_pemilik": rtPemilik,
        "nohp_pemilik": nohpPemilik,
        "email_pemilik": emailPemilik,
        "koordinat": koordinat,"date": date,
    };
}
