import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/laporan_1_controller.dart';

class Laporan1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Laporan1Controller>(
      () => Laporan1Controller(Get.find<Api>()),
    );
  }
}
