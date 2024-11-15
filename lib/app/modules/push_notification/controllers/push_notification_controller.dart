import 'dart:convert';

import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_topic.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PushNotificationController extends GetxController {
  late AuthModel authModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  XFile? imageFile = null;
  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
  }

  // void openGallery(BuildContext context) async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   imageFile = pickedFile!;
  //   update();
  //   print(imageFile);
  // }

  testing() async {
    var response = await http.get(Uri.parse(
        "https://yongen-bisa.com/bapenda_app/api_ver2/login/check_mytoken.php?nik=${authModel.nik}"));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      Map<String, dynamic> data =
          responseData["data"]; // Access as Map, not List

      String myToken = data["token"]; // Access token directly
      print(myToken);

      sendPushMessage(
          myToken, "Testing Pesan Notifikasi", "Pesan Berhasil diterima", "");
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  tambah() async {
    sendPushMessage_topic("user", judul.text, isi.text, "");
    getDefaultDialog().onFix(
        title: "Berhasil Kirim Broadcast",
        desc:
            "Broadcast berhasil dikirim, beberapa device mungkin akan mendapatkan lebih lama Notifikasi Broadcast",
        kategori: "success");
    hapusisi();
  }

  void hapusisi() {
    judul.clear();
    isi.clear();
    imageFile = null;
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
