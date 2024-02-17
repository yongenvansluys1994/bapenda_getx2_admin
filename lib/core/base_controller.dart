import 'package:bapenda_getx2_admin/app/modules/auth/utils/auth_exception.dart';
import 'package:bapenda_getx2_admin/core/app_exception.dart';
import 'package:bapenda_getx2_admin/core/exceptions/not_found_exception.dart';
import 'package:bapenda_getx2_admin/core/services/log_service.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  late LogService logService;

  void initialize(String instanceName) {
    logService = LogService(instanceName);
  }

  void handleException(AppException exception) {
    if (exception is AuthException) {
      logService.error(exception.toJsonString());
    }

    if (exception is NotFoundException) {
      logService.error(exception.toJsonString());
    }
  }
}
