import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/models/model_getpendaftaran.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PendaftaranSearchController extends GetxController {
  late AuthModel authModel;
  String? data;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelGetPendaftaran> datalist = <ModelGetPendaftaran>[].obs;
  TextEditingController searchbar = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    update();
  }

  Future fetch() async {
    datalist.clear();
    dismissKeyboard();
    final url = Uri.parse(
        '${URL_APP_API}/get_pendaftaran_admin/search.php?search=${searchbar.text}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['message'] == "tidak ada data") {
        isEmpty = true;
      } else {
        List newItems =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        final list = newItems.map<ModelGetPendaftaran>(
            (json) => ModelGetPendaftaran.fromJson(json));

        datalist.addAll(list);
        isEmpty = false;
      }

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
