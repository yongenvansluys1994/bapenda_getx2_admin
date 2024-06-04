import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_multiple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class JatuhTempoController extends GetxController with AuthCacheService {
  RxList list_id_wajib_pajak = [].obs;
  int grafik = 0; //status grafik tampil atau tidak tampil

  //DashboardServices services;
  Api api;
  JatuhTempoController(this.api);

  List<Map<String, String>> niksJatuhTempo = [];

  List<Map<String, String>> allTokens3 = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    update();
  }

  void fetchJatuhTempo() async {
    update();
    //EasyLoading.show();
    final data_mentah = await api.getJatuhTempo();
    //print(data_mentah);
    if (data_mentah == null) {
      update();
    } else if (data_mentah.isEmpty) {
      update();
    } else {
      niksJatuhTempo = []; // Inisialisasi jika null
      niksJatuhTempo.addAll(data_mentah
          .map((item) => {
                "nik": item.nikUser,
                "name": item.namaUsaha,
                "jatuh_tempo": item.jatuhTempo
              })
          .where((map) => map["nik"]!.isNotEmpty));

      //print(jsonEncode(niksJatuhTempo));
      update();
    }
    if (niksJatuhTempo.isNotEmpty) {
      getTokenList3(niksJatuhTempo);
    }

    //EasyLoading.dismiss();
    update();
  }

  void getTokenList3(List<Map<String, String>> niks) async {
    allTokens3.clear();
    // Buat daftar future untuk setiap panggilan dokumen Firestore
    List<Future<DocumentSnapshot>> futures = niks.map((nikMap) {
      String nik = nikMap['nik']!;
      return FirebaseFirestore.instance.collection("UserTokens").doc(nik).get();
    }).toList();

    // Tunggu semua future selesai
    List<DocumentSnapshot> snaps = await Future.wait(futures);

    // Iterasi melalui snaps dan niks untuk mendapatkan nama
    for (int i = 0; i < snaps.length; i++) {
      var snap = snaps[i];
      var nikMap = niks[i];
      if (snap.exists) {
        // Mengambil token dari data DocumentSnapshot
        String? token = snap['token'];
        // Menambahkan token ke dalam daftar allTokens3 bersama dengan nama
        if (token != null) {
          allTokens3.add({
            "token": token,
            "name": nikMap['name']!,
            "jatuh_tempo": nikMap['jatuh_tempo']!,
            "date_kirim": "${DateTime.now()}"
          });
        }
      }
    }
    // List<Map<String, String>> allTokensfake = [
    //   {
    //     "token":
    //         "emjCqIPwRB6sl6ahdgn3At:APA91bFqB8DXtfJmGG9Egn-0zQAk-6j7RbHz-WGxJX4hBDW5RrIQkr4dpRYspvQuxwqgO3SVK0ZB74twNf0x0j0pJ-9X2c9t0PrwlmByMfQdsmnLFl8Qvrs__-QDb9w2gAyR04nIXgtC",
    //     "name": "GUEST HOUSE  OMAH IJO",
    //     "jatuh_tempo": "2024-05-05"
    //   },
    //   {
    //     "token":
    //         "emjCqIPwRB6sl6ahdgn3At:APA91bFqB8DXtfJmGG9Egn-0zQAk-6j7RbHz-WGxJX4hBDW5RrIQkr4dpRYspvQuxwqgO3SVK0ZB74twNf0x0j0pJ-9X2c9t0PrwlmByMfQdsmnLFl8Qvrs__-QDb9w2gAyR04nIXgtC",
    //     "name": "McDONALDS BONTANG",
    //     "jatuh_tempo": "2024-05-05"
    //   }
    // ];

    sendPushMessagesJatuhTempo(allTokens3, "jatuh_tempo");
    print(jsonEncode("Notif jatuh tempo sudah terkirim"));
    print(jsonEncode(allTokens3));

    await insertJatuhTempo(allTokens3);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    // Perform cleanup tasks when the controller is disposed
    super.dispose();
    print('Controller disposed');
  }

  @override
  void onClose() {
    // Method onClose() dipanggil ketika controller dihapus dari memory
    // Anda dapat membatalkan request yang sedang berlangsung di sini

    super.onClose();
    print('Controller close');
  }
}
