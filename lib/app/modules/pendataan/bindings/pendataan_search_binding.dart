import 'package:get/get.dart';

import '../controllers/pendataan_search_controller.dart';

class PendataanSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendataanSearchController>(
      () => PendataanSearchController(),
    );
  }
}
