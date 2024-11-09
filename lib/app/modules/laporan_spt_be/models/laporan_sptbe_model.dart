// To parse this JSON data, do
//
//     final modelSptbe = modelSptbeFromJson(jsonString);

import 'dart:convert';

ModelSptbe modelSptbeFromJson(String str) =>
    ModelSptbe.fromJson(json.decode(str));

String modelSptbeToJson(ModelSptbe data) => json.encode(data.toJson());

class ModelSptbe {
  String namaPajak;
  String totalSpt;
  String totalPajak;

  ModelSptbe({
    required this.namaPajak,
    required this.totalSpt,
    required this.totalPajak,
  });

  factory ModelSptbe.fromJson(Map<String, dynamic> json) => ModelSptbe(
        namaPajak: json["nama_pajak"],
        totalSpt: json["total_spt"],
        totalPajak: json["total_pajak"],
      );

  Map<String, dynamic> toJson() => {
        "nama_pajak": namaPajak,
        "total_spt": totalSpt,
        "total_pajak": totalPajak,
      };
}
