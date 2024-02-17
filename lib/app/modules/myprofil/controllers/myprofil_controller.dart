import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/app/modules/myprofil/models/model_ads.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MyprofilController extends GetxController {
  Api api;
  MyprofilController(this.api);
  final dashboardController = Get.find<DashboardController>();
  late AuthModel authModel;
  XFile? imageFile = null;
  TextEditingController nama_usaha = TextEditingController();
  TextEditingController judul_promosi = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelAds> datalist = <ModelAds>[].obs;

  final Uri _url =
      Uri.parse('http://yongen-bisa.com/bapenda_app/request_delete.php');
  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;

    update();
  }

  Future<void> FetchlaunchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedFile!;
    update();
    print(imageFile);
  }

  void simpanData() {
    if (nama_usaha.text == "" ||
        judul_promosi.text == "" ||
        deskripsi.text == "") {
      RawSnackbar_bottom(
          message: "Seluruh Form wajib di isi, Periksa kembali",
          kategori: "error",
          duration: 2);
    } else if (imageFile == null) {
      RawSnackbar_bottom(
          message: "Upload Bukti LHP Tidak Boleh Kosong!",
          kategori: "error",
          duration: 2);
    } else {
      update();
    }
    update();
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
