import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/laporan_daftaruser_controller.dart';

class LaporanDaftaruserBindingOld extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanDaftaruserControllerOld>(
      () => LaporanDaftaruserControllerOld(Get.find<Api>()),
    );
  }
}
