import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/models/model_getpelaporan.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PendataanController extends GetxController {
  final controllerScroll = ScrollController();
  RxList<ModelGetpelaporan> datalist_all = <ModelGetpelaporan>[].obs;
  late AuthModel authModel;
  bool hasMore = true;
  int page = 1;
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetch_all();
    controllerScroll.addListener(() {
      if (controllerScroll.position.maxScrollExtent ==
          controllerScroll.offset) {
        fetch_all();
        update();
      }
      update();
    });
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        if (message.data['desc'] == "pelaporan_masuk") {
          refreshData(); //update history pelaporan
          update();
        }

        //Get.toNamed(Routes.LAPOR_PAJAK, arguments: authModel);
      }
    });
  }

  Future fetch_all() async {
    if (isLoading) return;
    const limit = 8;
    final url = Uri.parse(
        '${baseUrlApi}/get_pelaporan_admin/index.php?page=$page&limit=$limit&jenispajak=all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List newItems = json.decode(response.body);
      final list = newItems
          .map<ModelGetpelaporan>((json) => ModelGetpelaporan.fromJson(json));
      page++;
      isLoading = false;
      if (newItems.length < limit) {
        hasMore = false;
        update();
      }
      datalist_all.addAll(list);
      update();
    }
  }

  void refreshData() async {
    datalist_all.clear();
    const limit = 8;
    final url = Uri.parse(
        '${baseUrlApi}/get_pelaporan_admin/index.php?page=1&limit=$limit&jenispajak=all');
    final response = await http.get(url);
    List newItems = json.decode(response.body);
    final list = newItems
        .map<ModelGetpelaporan>((json) => ModelGetpelaporan.fromJson(json));

    isLoading = false;
    datalist_all.addAll(list);

    update();
  }

  @override
  void dispose() {
    super.dispose();
    controllerScroll.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
