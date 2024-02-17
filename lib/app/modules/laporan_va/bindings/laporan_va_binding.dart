import 'package:get/get.dart';

import '../controllers/laporan_va_controller.dart';

class LaporanVaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanVaController>(
      () => LaporanVaController(),
    );
  }
}
