import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:get/get.dart';

class DetailScreenController extends GetxController {
  String? url_image;
  @override
  void onInit() {
    super.onInit();
    url_image = Get.arguments;
    print('${URL_APP}/upload/${url_image}');
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
