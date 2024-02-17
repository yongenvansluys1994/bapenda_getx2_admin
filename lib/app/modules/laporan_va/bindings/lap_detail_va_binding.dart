import 'package:get/get.dart';

import '../controllers/lap_detail_va_controller.dart';

class LapDetailVaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LapDetailVaController>(
      () => LapDetailVaController(),
    );
  }
}
