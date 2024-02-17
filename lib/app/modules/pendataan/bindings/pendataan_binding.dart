import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_hiburan.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_hotel.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_katering.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_parkir.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller_restoran.dart';
import 'package:get/get.dart';

import '../controllers/pendataan_controller.dart';

class PendataanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendataanController>(
      () => PendataanController(),
    );
    Get.lazyPut<PendataanController_hotel>(
      () => PendataanController_hotel(),
    );
    Get.lazyPut<PendataanController_hiburan>(
      () => PendataanController_hiburan(),
    );
    Get.lazyPut<PendataanController_katering>(
      () => PendataanController_katering(),
    );
    Get.lazyPut<PendataanController_parkir>(
      () => PendataanController_parkir(),
    );
    Get.lazyPut<PendataanController_restoran>(
      () => PendataanController_restoran(),
    );
  }
}
