import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_bayaroffline/controllers/laporan_bayaroffline_controller.dart';
import 'package:get/get.dart';


class LaporanBayarOfflineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanBayarOfflineController>(
      () => LaporanBayarOfflineController(Get.find<Api>()),
    );
  }
}
