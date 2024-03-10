import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/controllers/pelaporan_history_controller.dart';
import 'package:get/get.dart';

import '../controllers/pendataan_detail_controller.dart';

class PendataanDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendataanDetailController>(
      () => PendataanDetailController(),
    );
    Get.lazyPut<PelaporanHistoryController>(
      () => PelaporanHistoryController(Get.find<Api>()),
    );
  }
}
