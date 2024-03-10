import 'dart:convert';

import 'package:bapenda_getx2_admin/app/modules/aktivitas/models/model_aktivitas.dart';
import 'package:bapenda_getx2_admin/app/modules/myprofil/models/model_ads.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/models/model_getpelaporanuser.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

//const baseUrlApi = 'https://yongen-bisa.com/bapenda_app/api';
const baseUrlApi = 'https://yongen-bisa.com/bapenda_app/api_ver2';
const URL_APP = "https://yongen-bisa.com/bapenda_app";
const URL_APP_API = "https://yongen-bisa.com/bapenda_app/api_ver2";
const URL_SIMPATDA = "http://simpatda.bontangkita.id/simpatda";
const String ApiFCM =
    "AAAAB69wS5U:APA91bGHHGdo_FzlMJlzO0rc4SUPIMt10OZLqzT60DwVdIU_SSmYkDVu5LRofJR3u9_AS8_ptJ-S5dHIB-7BYWoOTrHUY-pe04UKfLDuAH1ezeY7ohWZalRdShAfJOchSVR9wDuusnnj";

class Api {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrlApi,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final Dio dio2 = Dio(
    BaseOptions(
      baseUrl: "http://simpatda.bontangkita.id/simpatda/api_mobile2",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // Future<Response> getDataByDeliveryNumber(number) {
  //   return dio
  //       .get("/v1/api/rest/material-movement/$number?isReadableField=true");
  // }

  Future<Response> insertData(data) {
    return dio.post(
      "/login/login.php",
      data: data, //kalo post butuh data
    );
  }

  Future<Response> insertTokenFCM(data) {
    return dio.post(
      "/login/token_fcm.php",
      data: data,
    );
  }

  Future<Response> deleteData(int number) {
    return dio.delete("/v1/api/rest/material-movement/$number");
  }

  Future<List<ModelGetpelaporanUser>?> getPelaporanHistory(
      {required String id_wajib_pajak,
      required int tahun,
      required String jenispajak}) async {
    var response = await dio.get(
        "/get_pelaporan_merge/index.php?id_wajib_pajak=${id_wajib_pajak}&tahun=${tahun}&jenispajak=${jenispajak}");
    if (response.statusCode == 200) {
      //print(response.data); //untuk check response yang diberikan oleh url
      List data = json.decode(response.data);

      return data.map((e) => ModelGetpelaporanUser.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelAds>?> getPPID(nik) async {
    var response = await dio.get("/ppid/flat.php?kategori=user&nik=$nik");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelAds.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelAktivitas>?> getAktivitas() async {
    var response = await dio.get("/aktivitas/index.php");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelAktivitas.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<MarkerData>> fetchMarkersData() async {
    var response = await dio.get("/get_markers/index.php");
    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      //print(jsonEncode(data));
      return (data as List)
          .map((item) => MarkerData(
              latitude: item['lat'],
              longitude: item['lng'],
              id: item['id'].toString(),
              jenispajak: item['jenispajak'],
              nama_usaha: item['nama_usaha'],
              npwpd: item['npwpd'],
              nama_pemilik: item['nama_pemilik'],
              alamat_usaha: item['alamat_usaha']))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<List<ModelObjekku>?> getObjekku() async {
  //   var response = await http.get(Uri.parse("${URL_APP_API}/api/objekku/123"));
  //   if (response.statusCode == 200) {
  //     List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
  //     return data.map((e) => ModelObjekku.fromJson(e)).toList();
  //   } else {
  //     return null;
  //   }
  // }

  // static Future<List<ModeldataBerita>?> databeritaall() async {
  //   final url = '$baseUrlApi';
  //   final res = await http.get(Uri.parse(url)).timeout(timeLimit);

  //   print(url);

  //   if (res.statusCode == 200) {
  //     final json = await compute(jsonDecode, res.body);

  //     if (json is Map && json.containsKey('data')) {
  //       final data = json['data']['data'];

  //       if (data is List) {
  //         return data
  //             .map<ModeldataBerita>((u) => ModeldataBerita.fromJson(u))
  //             .toList();
  //       }
  //     }
  //   }

  //   return null;
  // }

  // Future<Response> updateData(int number, DeliveryNumberData data) {
  //   return dio.put(
  //     "/v1/api/rest/material-movement/$number",
  //     data: data,
  //   );
  // }
}

class MarkerData {
  final String nama_usaha;
  final String jenispajak;
  final String npwpd;
  final String nama_pemilik;
  final String alamat_usaha;
  final double latitude;
  final double longitude;
  final String id;

  MarkerData(
      {required this.nama_usaha,
      required this.jenispajak,
      required this.npwpd,
      required this.nama_pemilik,
      required this.alamat_usaha,
      required this.latitude,
      required this.longitude,
      required this.id});
}
