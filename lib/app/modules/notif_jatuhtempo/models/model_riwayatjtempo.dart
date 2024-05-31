// To parse this JSON data, do
//
//     final modelRiwayatJtempo = modelRiwayatJtempoFromJson(jsonString);

import 'dart:convert';

ModelRiwayatJtempo modelRiwayatJtempoFromJson(String str) =>
    ModelRiwayatJtempo.fromJson(json.decode(str));

String modelRiwayatJtempoToJson(ModelRiwayatJtempo data) =>
    json.encode(data.toJson());

class ModelRiwayatJtempo {
  String token;
  String name;
  DateTime jatuhTempo;
  DateTime dateKirim;

  ModelRiwayatJtempo({
    required this.token,
    required this.name,
    required this.jatuhTempo,
    required this.dateKirim,
  });

  factory ModelRiwayatJtempo.fromJson(Map<String, dynamic> json) =>
      ModelRiwayatJtempo(
        token: json["token"],
        name: json["name"],
        jatuhTempo: DateTime.parse(json["jatuh_tempo"]),
        dateKirim: DateTime.parse(json["date_kirim"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "jatuh_tempo":
            "${jatuhTempo.year.toString().padLeft(4, '0')}-${jatuhTempo.month.toString().padLeft(2, '0')}-${jatuhTempo.day.toString().padLeft(2, '0')}",
        "date_kirim": dateKirim.toIso8601String(),
      };
}
