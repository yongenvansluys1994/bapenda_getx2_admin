import 'package:get/get.dart';

import '../controllers/laporan_qris_controller.dart';

class LaporanQrisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanQrisController>(
      () => LaporanQrisController(),
    );
  }
}
