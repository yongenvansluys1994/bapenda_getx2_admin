import 'dart:convert';

import 'package:bapenda_getx2_admin/app/modules/aktivitas/models/model_aktivitas.dart';
import 'package:bapenda_getx2_admin/app/modules/chat/models/model_chat.dart';
import 'package:bapenda_getx2_admin/app/modules/chat/models/model_checkroom.dart';
import 'package:bapenda_getx2_admin/app/modules/chat_room/models/model_listuserchat.dart';
import 'package:bapenda_getx2_admin/app/modules/chat_room/models/model_ruangchat.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_1/models/laporan_1_model.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_2/models/laporan_2_model.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_daftaruser/models/model_lapdaftaruser.dart';
import 'package:bapenda_getx2_admin/app/modules/myprofil/models/model_ads.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2_admin/app/modules/push_notification/models/model_notifjtempo.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
//import 'package:http/http.dart' as http;

//const baseUrlApi = 'https://yongen-bisa.com/bapenda_app/api';
const baseUrlApi = 'https://yongen-bisa.com/bapenda_app/api_ver2';
const URL_APP = "https://yongen-bisa.com/bapenda_app";
const URL_APP_API = "https://yongen-bisa.com/bapenda_app/api_ver2";
const URL_SIMPATDA = "http://simpatda.bontangkita.id/simpatda";
const URL_APPSIMPATDA = "http://simpatda.bontangkita.id/api_ver2";
const String ApiFCM =
    "AAAAB69wS5U:APA91bGHHGdo_FzlMJlzO0rc4SUPIMt10OZLqzT60DwVdIU_SSmYkDVu5LRofJR3u9_AS8_ptJ-S5dHIB-7BYWoOTrHUY-pe04UKfLDuAH1ezeY7ohWZalRdShAfJOchSVR9wDuusnnj";
const tokenApi = "edee9b7c-b723-4990-a674-dfd6da7efdd1";

final Dio dio1 = Dio(
  BaseOptions(
    baseUrl: baseUrlApi,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ),
);

final Dio dio3 = Dio(
  BaseOptions(
    baseUrl: URL_APPSIMPATDA,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ),
);

final Dio dioChat = Dio(
  BaseOptions(
    baseUrl: URL_APPSIMPATDA,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ),
);

Future<List<ModelRuangChat>?> getRuangChat(id_userwp) async {
  var response = await dioChat.get("/chat/list_room.php?id_userwp=$id_userwp");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

    return data.map((e) => ModelRuangChat.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<List<ModelListUserChat>?> getListUserChat() async {
  var response = await dioChat.get("/chat/list_user.php");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];
    return data.map((e) => ModelListUserChat.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<List<ModelChat>?> getChat(roomID) async {
  var response = await dioChat.get("/chat/isi_chat.php?room_id=$roomID");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

    return data.map((e) => ModelChat.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<Response> readChat(int id_userwp, roomID) {
  return dioChat.put(
    "/chat/read_chat.php?id_userwp=$id_userwp&room_id=$roomID",
  );
}

Future<Response> sendChat(data) {
  return dioChat.post(
    "/chat/send_chat.php",
    data: data,
  );
}

Future<List<ModelCheckRoom>?> checkRoom(id_userwp) async {
  var response = await dioChat.get("/chat/check_room.php?id_userwp=$id_userwp");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];
    return data.map((e) => ModelCheckRoom.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<List<ModelCheckRoom>?> checkRoomAdmin(id_userwp, id_target) async {
  var response = await dioChat.get(
      "/chat/check_room_admin.php?id_userwp=$id_userwp&id_target=$id_target");
  if (response.statusCode == 200) {
    List data = (json.decode(response.data) as Map<String, dynamic>)["data"];
    return data.map((e) => ModelCheckRoom.fromJson(e)).toList();
  } else {
    return null;
  }
}

Future<Response> insertJatuhTempo(List<Map<String, String>> data) {
  return dio3.post(
    "/notifikasi/insert_jatuhtempo.php",
    data: {'token': jsonEncode(data)},
  );
}

Future<Response> insertNotifTolak(data) {
  return dio3.post(
    "/notifikasi/notif_penolakan.php",
    data: data,
  );
}

Future<Response> cekJatuhTempo() {
  return dio3.get("/notifikasi/cek_jatuhtempo.php");
}

Future<Response> cekhasUnreadChat(String? idUserwp) {
  return dioChat.get("/chat/has_unread.php?id_userwp=$idUserwp");
}

Future<Response> checkNIKproses(String? nik) {
  return dio1.get("/upload_image/check_nik.php?nik=$nik");
}

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

  Future<List<ModelLaporan1>?> getLaporanSPTBE(
      {DateTime? masa_awal, DateTime? masa_akhir}) async {
    String masa_awalformat = DateFormat('yyyy-MM-dd').format(masa_awal!);
    String masa_akhirformat = DateFormat('yyyy-MM-dd').format(masa_akhir!);
    var response = await dio2.get(
        "/laporan_SPTBE/edee9b7c-b723-4990-a674-dfd6da7efdd1/$masa_awalformat/$masa_akhirformat");
    if (response.statusCode == 200) {
      List data = json.decode(response.data);

      return data.map((e) => ModelLaporan1.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelLaporan1>?> getLaporan1(
      {DateTime? masa_awal, DateTime? masa_akhir}) async {
    String masa_awalformat = DateFormat('yyyy-MM-dd').format(masa_awal!);
    String masa_akhirformat = DateFormat('yyyy-MM-dd').format(masa_akhir!);
    var response = await dio2.get(
        "/laporan_1/edee9b7c-b723-4990-a674-dfd6da7efdd1/$masa_awalformat/$masa_akhirformat");
    if (response.statusCode == 200) {
      List data = json.decode(response.data);

      return data.map((e) => ModelLaporan1.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelLapDaftarUser>?> getLapDaftarUser(
      {DateTime? masa_awal, DateTime? masa_akhir, String? jenispajak}) async {
    String masa_awalformat = DateFormat('yyyy-MM-dd').format(masa_awal!);
    String masa_akhirformat = DateFormat('yyyy-MM-dd').format(masa_akhir!);
    var response = await dio.get(
        "/laporan/laporan_daftaruser.php?masa_awal=${masa_awalformat}&masa_akhir=${masa_akhirformat}&jenispajak=${jenispajak}");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelLapDaftarUser.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelLapDaftarUser>?> getLapDaftarUserOld(
      {DateTime? masa_awal, DateTime? masa_akhir, String? jenispajak}) async {
    String masa_awalformat = DateFormat('yyyy-MM-dd').format(masa_awal!);
    String masa_akhirformat = DateFormat('yyyy-MM-dd').format(masa_akhir!);
    var response = await dio.get(
        "/laporan/laporan_daftaruser_old.php?masa_awal=${masa_awalformat}&masa_akhir=${masa_akhirformat}&jenispajak=${jenispajak}");
    if (response.statusCode == 200) {
      List data = (json.decode(response.data) as Map<String, dynamic>)["data"];

      return data.map((e) => ModelLapDaftarUser.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelLaporan2>?> getLaporanBayarOnline(
      {DateTime? masa_awal, DateTime? masa_akhir}) async {
    String masa_awalformat = DateFormat('yyyy-MM-dd').format(masa_awal!);
    String masa_akhirformat = DateFormat('yyyy-MM-dd').format(masa_akhir!);
    var response = await dio2.get(
        "/laporan_bayaronline/edee9b7c-b723-4990-a674-dfd6da7efdd1/$masa_awalformat/$masa_akhirformat");
    if (response.statusCode == 200) {
      List data = json.decode(response.data);

      return data.map((e) => ModelLaporan2.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelLaporan2>?> getLaporanBayarOffline(
      {DateTime? masa_awal, DateTime? masa_akhir}) async {
    String masa_awalformat = DateFormat('yyyy-MM-dd').format(masa_awal!);
    String masa_akhirformat = DateFormat('yyyy-MM-dd').format(masa_akhir!);
    var response = await dio2.get(
        "/laporan_bayaroffline/edee9b7c-b723-4990-a674-dfd6da7efdd1/$masa_awalformat/$masa_akhirformat");
    if (response.statusCode == 200) {
      List data = json.decode(response.data);

      return data.map((e) => ModelLaporan2.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelLaporan2>?> getLaporan2(
      {DateTime? masa_awal, DateTime? masa_akhir}) async {
    String masa_awalformat = DateFormat('yyyy-MM-dd').format(masa_awal!);
    String masa_akhirformat = DateFormat('yyyy-MM-dd').format(masa_akhir!);
    var response = await dio2.get(
        "/laporan_2/edee9b7c-b723-4990-a674-dfd6da7efdd1/$masa_awalformat/$masa_akhirformat");
    if (response.statusCode == 200) {
      List data = json.decode(response.data);

      return data.map((e) => ModelLaporan2.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<ModelNotifJtempo>?> getJatuhTempo() async {
    var response = await dio3.get("/notifikasi/getjatuhtempo.php");
    if (response.statusCode == 200) {
      List data = json.decode(response.data);

      return data.map((e) => ModelNotifJtempo.fromJson(e)).toList();
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
