import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/models/model_getpelaporan.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PendataanSearchController extends GetxController {
  late AuthModel authModel;
  String? data;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelGetpelaporan> datalist = <ModelGetpelaporan>[].obs;
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
        '${baseUrlApi}/get_pelaporan_admin/search.php?search=${searchbar.text}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if (json.decode(response.body) == null) {
        isEmpty = true;
      } else {
        isEmpty = false;
        List newItems = json.decode(response.body);
        final list = newItems
            .map<ModelGetpelaporan>((json) => ModelGetpelaporan.fromJson(json));

        datalist.addAll(list);
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
