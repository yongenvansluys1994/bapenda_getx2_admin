import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/laporan_sptbe_controller.dart';

class LaporanSPTBEBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanSPTBEController>(
      () => LaporanSPTBEController(Get.find<Api>()),
    );
  }
}
