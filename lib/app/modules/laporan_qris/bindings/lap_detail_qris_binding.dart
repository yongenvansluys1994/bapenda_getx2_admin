import 'package:get/get.dart';

import '../controllers/lap_detail_qris_controller.dart';

class LapDetailQrisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LapDetailQrisController>(
      () => LapDetailQrisController(),
    );
  }
}
