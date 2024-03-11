import 'package:get/get.dart';

import '../controllers/pendaftaran_search_controller.dart';

class PendaftaranSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendaftaranSearchController>(
      () => PendaftaranSearchController(),
    );
  }
}
