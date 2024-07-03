import 'dart:convert';
import 'package:bapenda_getx2_admin/app/modules/notif_jatuhtempo/models/model_riwayatjtempo.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class NotifJatuhtempoController extends GetxController {
  RxList<ModelRiwayatJtempo> datalist = <ModelRiwayatJtempo>[].obs;
  bool isLoading = false;
  String jsonData = '';
  int page = 1;
  bool hasMore = true;
  final controllerScroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchData();
    controllerScroll.addListener(() {
      if (controllerScroll.position.maxScrollExtent ==
          controllerScroll.offset) {
        fetchData();
        update();
      }
    });
  }

  Future fetchData() async {
    if (isLoading) return;
    const limit = 10;
    final url = Uri.parse(
        'http://simpatda.bontangkita.id/api_ver2/notifikasi/riwayat_jatuhtempo.php?page=$page&limit=$limit');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List newItems = json.decode(response.body);
      final list = newItems
          .map<ModelRiwayatJtempo>((json) => ModelRiwayatJtempo.fromJson(json));
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
