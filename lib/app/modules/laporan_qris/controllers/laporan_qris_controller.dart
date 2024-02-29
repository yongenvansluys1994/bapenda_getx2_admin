import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanQrisController extends GetxController {
  late AuthModel authModel;
  late List<String> months;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchMonths();
    update();
  }

  void fetchMonths() {
    months = [];
    DateTime now = DateTime.now();
    int currentYear = now.year;

    for (int i = 1; i <= 12; i++) {
      DateTime month = DateTime(currentYear, i);
      String monthName = DateFormat.MMMM().format(month);
      months.add(monthName);
    }
    print(months);
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}