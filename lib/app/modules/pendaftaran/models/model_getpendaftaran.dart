// To parse this JSON data, do
//
//     final modelGetPendaftaran = modelGetPendaftaranFromJson(jsonString);

import 'dart:convert';

List<ModelGetPendaftaran> modelGetPendaftaranFromJson(String str) =>
    List<ModelGetPendaftaran>.from(
        json.decode(str).map((x) => ModelGetPendaftaran.fromJson(x)));

String modelGetPendaftaranToJson(List<ModelGetPendaftaran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelGetPendaftaran {
  ModelGetPendaftaran({
    required this.idDaftarwp,
    required this.nikUser,
    required this.idWajibPajak,
    required this.npwpd,
    required this.namaUsaha,
    required this.alamatUsaha,
    required this.rtUsaha,
    required this.kelUsaha,
    required this.kecUsaha,
    required this.kotaUsaha,
    required this.nohpUsaha,
    required this.emailUsaha,
    required this.jenispajak,
    required this.namaPemilik,
    required this.pekerjaanPemilik,
    required this.alamatPemilik,
    required this.rtPemilik,
    required this.kelPemilik,
    required this.kecPemilik,
    required this.kotaPemilik,
    required this.nohpPemilik,
    required this.emailPemilik,
    required this.lat,
    required this.lng,
    required this.status,
    required this.imageKtp,
    required this.imageNpwp,
    required this.lastActive,
  });

  String idDaftarwp;
  String nikUser;
  String idWajibPajak;
  String npwpd;
  String namaUsaha;
  String alamatUsaha;
  String rtUsaha;
  String kelUsaha;
  String kecUsaha;
  String kotaUsaha;
  String nohpUsaha;
  String emailUsaha;
  String jenispajak;
  String namaPemilik;
  String pekerjaanPemilik;
  String alamatPemilik;
  String rtPemilik;
  String kelPemilik;
  String kecPemilik;
  String kotaPemilik;
  String nohpPemilik;
  String emailPemilik;
  String lat;
  String lng;
  String status;
  String imageKtp;
  String imageNpwp;
  String lastActive;

  factory ModelGetPendaftaran.fromJson(Map<String, dynamic> json) =>
      ModelGetPendaftaran(
        idDaftarwp: json["id_daftarwp"],
        nikUser: json["nik_user"],
        idWajibPajak: json["id_wajib_pajak"],
        npwpd: json["npwpd"],
        namaUsaha: json["nama_usaha"],
        alamatUsaha: json["alamat_usaha"],
        rtUsaha: json["rt_usaha"],
        kelUsaha: json["kel_usaha"],
        kecUsaha: json["kec_usaha"],
        kotaUsaha: json["kota_usaha"],
        nohpUsaha: json["nohp_usaha"],
        emailUsaha: json["email_usaha"],
        jenispajak: json["jenispajak"],
        namaPemilik: json["nama_pemilik"],
        pekerjaanPemilik: json["pekerjaan_pemilik"],
        alamatPemilik: json["alamat_pemilik"],
        rtPemilik: json["rt_pemilik"],
        kelPemilik: json["kel_pemilik"],
        kecPemilik: json["kec_pemilik"],
        kotaPemilik: json["kota_pemilik"],
        nohpPemilik: json["nohp_pemilik"],
        emailPemilik: json["email_pemilik"],
        lat: json["lat"],
        lng: json["lng"],
        status: json["status"],
        imageKtp: json["image_ktp"],
        imageNpwp: json["image_npwp"],
        lastActive: json["last_active"],
      );

  Map<String, dynamic> toJson() => {
        "id_daftarwp": idDaftarwp,
        "nik_user": nikUser,
        "id_wajib_pajak": idWajibPajak,
        "npwpd": npwpd,
        "nama_usaha": namaUsaha,
        "alamat_usaha": alamatUsaha,
        "rt_usaha": rtUsaha,
        "kel_usaha": kelUsaha,
        "kec_usaha": kecUsaha,
        "kota_usaha": kotaUsaha,
        "nohp_usaha": nohpUsaha,
        "email_usaha": emailUsaha,
        "jenispajak": jenispajak,
        "nama_pemilik": namaPemilik,
        "pekerjaan_pemilik": pekerjaanPemilik,
        "alamat_pemilik": alamatPemilik,
        "rt_pemilik": rtPemilik,
        "kel_pemilik": kelPemilik,
        "kec_pemilik": kecPemilik,
        "kota_pemilik": kotaPemilik,
        "nohp_pemilik": nohpPemilik,
        "email_pemilik": emailPemilik,
        "lat": lat,
        "lng": lng,
        "status": status,
        "image_ktp": imageKtp,
        "image_npwp": imageNpwp,
        "last_active": lastActive,
      };
}
