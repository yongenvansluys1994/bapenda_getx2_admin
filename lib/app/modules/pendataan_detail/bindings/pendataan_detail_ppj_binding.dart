import 'package:get/get.dart';

import '../controllers/pendataan_detail_ppj_controller.dart';

class PendataanDetailPpjBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendataanDetailPpjController>(
      () => PendataanDetailPpjController(),
    );
  }
}
