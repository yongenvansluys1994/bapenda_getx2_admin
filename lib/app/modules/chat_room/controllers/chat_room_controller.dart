import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/chat_room/models/model_ruangchat.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  late AuthModel authModel;
  RxList<ModelRuangChat> datalist = <ModelRuangChat>[].obs;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    FetchData();
  }

  Future<void> FetchData() async {
    datalist.clear();
    try {
      isLoading = true;

      final datauser = await getRuangChat(authModel.idUserwp);

      if (datauser == null) {
        isFailed = true;
      } else if (datauser.isEmpty) {
        isEmpty = true;
      } else {
        datalist.clear();
        datalist.addAll(datauser);
        isEmpty = false;
      }

      isLoading = false;
      update();
    } on DioError catch (ex) {
      var errorMessage = "";
      if (ex.type == DioErrorType.connectionTimeout ||
          ex.type == DioErrorType.connectionError ||
          ex.type == DioErrorType.receiveTimeout ||
          ex.type == DioErrorType.sendTimeout) {
        errorMessage = "Limit Connection, Koneksi anda bermasalah";
      } else {
        errorMessage = "$ex";
      }
      RawSnackbar_top(message: "$errorMessage", kategori: "error", duration: 4);
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
