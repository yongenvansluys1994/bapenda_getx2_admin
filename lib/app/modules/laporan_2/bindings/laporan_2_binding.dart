import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/laporan_2_controller.dart';

class Laporan2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Laporan2Controller>(
      () => Laporan2Controller(Get.find<Api>()),
    );
  }
}
