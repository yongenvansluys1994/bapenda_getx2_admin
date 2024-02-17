import 'package:get/get.dart';

import '../controllers/pendataan_detail_controller.dart';

class PendataanDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendataanDetailController>(
      () => PendataanDetailController(),
    );
  }
}
