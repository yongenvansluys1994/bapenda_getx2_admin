import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/login/controllers/login_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/login/services/login_services.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        LoginServices(
          Get.find<Api>(),
        ),
      ),
    );
  }
}
