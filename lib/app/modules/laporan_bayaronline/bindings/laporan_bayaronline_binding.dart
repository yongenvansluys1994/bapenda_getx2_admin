import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/laporan_bayaronline_controller.dart';

class LaporanBayarOnlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanBayarOnlineController>(
      () => LaporanBayarOnlineController(Get.find<Api>()),
    );
  }
}
