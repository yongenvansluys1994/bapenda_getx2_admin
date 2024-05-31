import 'package:get/get.dart';

import '../controllers/notif_jatuhtempo_controller.dart';

class NotifJatuhtempoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifJatuhtempoController>(
      () => NotifJatuhtempoController(),
    );
  }
}
