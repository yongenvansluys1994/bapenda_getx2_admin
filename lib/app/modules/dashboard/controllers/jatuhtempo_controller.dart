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
  List<String> allTokens = [];
  List<String> allTokens2 = [];
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
    getTokenList3(niksJatuhTempo);

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
            "jatuh_tempo": nikMap['jatuh_tempo']!
          });
        }
      }
    }
    print(jsonEncode(allTokens3));
  }

  void getTokenList(List<String> niks) async {
    allTokens2.clear();
    // Buat daftar future untuk setiap panggilan dokumen Firestore
    List<Future<DocumentSnapshot>> futures = niks.map((nik) {
      return FirebaseFirestore.instance.collection("UserTokens").doc(nik).get();
    }).toList();

    // Tunggu semua future selesai
    List<DocumentSnapshot> snaps = await Future.wait(futures);

    // Simpan semua token dalam daftar
    snaps.forEach((snap) {
      if (snap.exists) {
        // Mengambil token dari data DocumentSnapshot
        String? token = snap['token'];
        // Menambahkan token ke dalam daftar allTokens
        if (token != null) {
          allTokens.add(token);
        }
      }
    });

    sendPushMessagesMultiple(
        allTokens2,
        "Pelaporan Pajak telah diverifikasi Admin, anda dapat melakukan pembayaran dengan E-Billing",
        "Buka Aplikasi untuk melihat Detailnya",
        "jatuh_tempo");
  }

  void getTokenList2() async {
    allTokens2.clear();
    // Buat daftar future untuk setiap panggilan dokumen Firestore

    // Mengonversi daftar token menjadi JSON array dengan format yang diinginkan

    allTokens2 = [
      'elMr6E-KS0qML0WCVRvba2:APA91bFtuaEsEOi_oF0MfMeGKn7rKcx1XGkuJyvZdXafjzYZB5-Yb9oH2s5KPGoo2dCYxy8Phaq4-bBGEptfH47FPWN-mA6_invBEl_eOpdOwdA4hLLLEyV7JitBxZMe5bSSpWjEIFJN'
    ];
    print(jsonEncode(allTokens2));
    sendPushMessagesMultiple(
        allTokens2,
        "Jatuh Tempo Pajak Anda 7 hari lagi, Bayar lebih cepat untuk menghindari denda",
        "Buka Aplikasi untuk melihat Detailnya",
        "jatuh_tempo");
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
