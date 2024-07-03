// To parse this JSON data, do
//
//     final modelListUserChat = modelListUserChatFromJson(jsonString);

import 'dart:convert';

ModelListUserChat modelListUserChatFromJson(String str) =>
    ModelListUserChat.fromJson(json.decode(str));

String modelListUserChatToJson(ModelListUserChat data) =>
    json.encode(data.toJson());

class ModelListUserChat {
  String idUserwp;
  String nama;
  String nik;
  String foto;
  String token;
  String namaUsaha;

  ModelListUserChat({
    required this.idUserwp,
    required this.nama,
    required this.foto,
    required this.nik,
    required this.token, 
    required this.namaUsaha,
  });

  factory ModelListUserChat.fromJson(Map<String, dynamic> json) =>
      ModelListUserChat(
        idUserwp: json["id_userwp"],
        nama: json["nama"],
        nik: json["nik"],
        foto: json["foto"],
        token: json["token"], 
        namaUsaha: json["nama_usaha"],
      );

  Map<String, dynamic> toJson() => {
        "id_userwp": idUserwp,
        "nama": nama,
        "nik": nik,
        "foto": foto,
        "token": token,
        "nama_usaha": namaUsaha,
      };
}
