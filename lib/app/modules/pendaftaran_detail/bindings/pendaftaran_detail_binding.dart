import 'package:get/get.dart';

import '../controllers/pendaftaran_detail_controller.dart';

class PendaftaranDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendaftaranDetailController>(
      () => PendaftaranDetailController(),
    );
  }
}
