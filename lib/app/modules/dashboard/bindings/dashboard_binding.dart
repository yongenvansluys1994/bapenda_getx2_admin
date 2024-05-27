import 'package:bapenda_getx2_admin/app/core/api/api.dart';

import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/controllers/jatuhtempo_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(Get.find<Api>()),
    );
    Get.lazyPut<JatuhTempoController>(
      () => JatuhTempoController(Get.find<Api>()),
    );
  }
}
