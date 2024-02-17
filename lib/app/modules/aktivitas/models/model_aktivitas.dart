// To parse this JSON data, do
//
//     final modelAktivitas = modelAktivitasFromJson(jsonString);

import 'dart:convert';

ModelAktivitas modelAktivitasFromJson(String str) =>
    ModelAktivitas.fromJson(json.decode(str));

String modelAktivitasToJson(ModelAktivitas data) => json.encode(data.toJson());

class ModelAktivitas {
  String id;
  String nik;
  String nama;
  String kegiatan;
  DateTime date;

  ModelAktivitas({
    required this.id,
    required this.nik,
    required this.nama,
    required this.kegiatan,
    required this.date,
  });

  factory ModelAktivitas.fromJson(Map<String, dynamic> json) => ModelAktivitas(
        id: json["id"],
        nik: json["nik"],
        nama: json["nama"],
        kegiatan: json["kegiatan"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "nama": nama,
        "kegiatan": kegiatan,
        "date": date.toIso8601String(),
      };
}
