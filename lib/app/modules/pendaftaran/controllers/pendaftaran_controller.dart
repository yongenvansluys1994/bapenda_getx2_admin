import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/models/model_getpendaftaran.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PendaftaranController extends GetxController {
  http.Client httpClient = http.Client();
  bool isEmpty = false;
  bool isFailed = false;
  late AuthModel authModel;
  bool hasMore = true;
  int page = 1;
  bool isLoading = false;
  RxList<ModelGetPendaftaran> datalist = <ModelGetPendaftaran>[].obs;
  final controllerScroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetch();
    controllerScroll.addListener(() {
      if (controllerScroll.position.maxScrollExtent ==
          controllerScroll.offset) {
        fetch();
        update();
      }
    });
    listenFCM();
    update();
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        if (message.data['desc'] == "pendaftaran_masuk") {
          refreshData(); //update history pelaporan
          update();
        }

        //Get.toNamed(Routes.LAPOR_PAJAK, arguments: authModel);
      }
    });
  }

  Future fetch() async {
    if (isLoading) return;
    const limit = 8;
    final url = Uri.parse(
        '${URL_APP_API}/get_pendaftaran_admin/index.php?page=$page&limit=$limit');
    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      List newItems =
          (json.decode(response.body) as Map<String, dynamic>)["data"];
      final list = newItems.map<ModelGetPendaftaran>(
          (json) => ModelGetPendaftaran.fromJson(json));
      page++;
      isLoading = false;

      if (newItems.length < limit) {
        hasMore = false;
        update();
      }
      datalist.addAll(list);
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    controllerScroll.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    httpClient.close();
    super.onClose();
  }

  void refreshData() async {
    datalist.clear();
    const limit = 8;
    final url = Uri.parse(
        '${URL_APP_API}/get_pendaftaran_admin/index.php?page=1&limit=$limit');
    final response = await http.get(url);
    List newItems =
        (json.decode(response.body) as Map<String, dynamic>)["data"];
    final list = newItems
        .map<ModelGetPendaftaran>((json) => ModelGetPendaftaran.fromJson(json));

    isLoading = false;
    datalist.addAll(list);

    update();
  }
}
