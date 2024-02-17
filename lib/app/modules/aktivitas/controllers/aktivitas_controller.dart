import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/aktivitas/models/model_aktivitas.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AktivitasController extends GetxController {
  Api api;
  AktivitasController(this.api);
  bool isEmpty = false;
  bool isFailed = false;
  late AuthModel authModel;
  bool hasMore = true;
  int page = 1;
  bool isLoading = false;
  RxList<ModelAktivitas> datalist = <ModelAktivitas>[].obs;
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
  }

  Future fetch() async {
    if (isLoading) return;
    const limit = 10;
    final url =
        Uri.parse('${URL_APP_API}/aktivitas/index.php?page=$page&limit=$limit');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List newItems =
          (json.decode(response.body) as Map<String, dynamic>)["data"];
      final list =
          newItems.map<ModelAktivitas>((json) => ModelAktivitas.fromJson(json));
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
  void onClose() {
    super.onClose();
  }
}
