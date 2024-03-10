import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/controllers/pelaporan_history_controller.dart';
import 'package:get/get.dart';

import '../controllers/pendaftaran_detail_controller.dart';

class PendaftaranDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendaftaranDetailController>(
      () => PendaftaranDetailController(),
    );
    Get.lazyPut<PelaporanHistoryController>(
      () => PelaporanHistoryController(Get.find<Api>()),
    );
  }
}
