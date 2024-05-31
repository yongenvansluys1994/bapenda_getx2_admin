import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_topic.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  tambah() async {
    sendPushMessage_topic("user", judul.text, isi.text);
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
