import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/chat/models/model_chat.dart';
import 'package:bapenda_getx2_admin/app/modules/chat_room/controllers/chat_room_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_multiple.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2_admin/widgets/logger.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  late AuthModel authModel;
  RxList<ModelChat> datalist = <ModelChat>[].obs;
  TextEditingController textController = TextEditingController();
  String? roomID;
  String? target_id;
  String? target_nik;
  String? sender_name;
  bool isFirstChat = false;
  List<Map<String, String>> token_sender = [];
  final ChatRoomController chatRoomCon = Get.find();

  @override
  void onInit() async {
    super.onInit();
    listenFCM();
    authModel = Get.arguments;
    roomID = Get.parameters['room_id'];
    target_id = Get.parameters['target_id'];
    target_nik = Get.parameters['target_nik'];
    sender_name = Get.parameters['sender_name'];
    final resultCheckRoom = await checkRoomAdmin(
        int.parse("${authModel.idUserwp}"),
        int.parse(
            "${target_id}")); //check room untuk mendapatkan token member group
    if (resultCheckRoom!.isNotEmpty) {
      isFirstChat = false;
      List<String> allToken = resultCheckRoom[0].allToken;
      for (String token in allToken) {
        token_sender.add({"token": token}); //token untuk push notifikasi
      }
      FetchData(roomID);
      readChat(int.parse("${authModel.idUserwp}"), roomID).then((value) {
        chatRoomCon.FetchData();
      });
      update();
    } else {
      isFirstChat = true;
      logInfo("tidak ada room chat");
    }
  }

  Future send_Chat() async {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
      update();
    } else {
      try {
        // Memanggil sendChat dan menunggu hasilnya
        var response = await sendChat({
          'id_userwp': int.parse("${authModel.idUserwp}"),
          'target_id_userwp': int.parse("${target_id}"),
          'room_id': '${roomID}',
          'text': '${textController.text}',
          'type': 'lama',
          'type_room': null,
          'chat_room': 'admin',
        });

        // Memeriksa status respons
        if (response.statusCode == 200) {
          dismissKeyboard();
          // Mengolah respons jika sukses
          var responseData = response.data;
          var decodedResponse = jsonDecode(responseData);
          var data = decodedResponse['data'];
          // Iterasi melalui setiap item di 'data' dan tambahkan ke datalist
          for (var item in data) {
            datalist.add(ModelChat.fromJson(item));
          }
          // Mengurutkan datalist berdasarkan sent_at (terbaru di paling bawah)
          datalist.sort((a, b) => b.sentAt.compareTo(a.sentAt));
          // Update UI
          isFirstChat = false;
          update();

          sendPushMessagesChat(token_sender, "${authModel.nama}",
              "${textController.text}", "chat_masuk", jsonDecode(responseData));
          textController.clear();
          //logInfo("${jsonEncode(datalist)}");
          // Lakukan sesuatu dengan responseData
        } else {
          // Mengolah respons jika gagal
          logInfo("Failed to send message: ${response.statusMessage}");
        }
      } catch (e) {
        // Menangani error
        print("Error: $e");
      }

      update();
    }
  }

  Future send_NewChat() async {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
      update();
    } else {
      try {
        // Memanggil sendChat dan menunggu hasilnya
        var response = await sendChat({
          'id_userwp': int.parse("${authModel.idUserwp}"),
          'target_id_userwp': int.parse("${target_id}"),
          'room_id': '',
          'text': '${textController.text}',
          'type': 'baru',
          'type_room': null,
          'chat_room': 'admin',
        });

        // Memeriksa status respons
        if (response.statusCode == 200) {
          dismissKeyboard();
          // Mengolah respons jika sukses
          var responseData = response.data;
          var decodedResponse = jsonDecode(responseData);
          var data = decodedResponse['data'];
          if (isFirstChat) {
            var token = decodedResponse['token'];
            token_sender.add({"token": token[0]['token_target']});
            roomID = data[0]['room_id'];
          }
          

          // Iterasi melalui setiap item di 'data' dan tambahkan ke datalist
          for (var item in data) {
            datalist.add(ModelChat.fromJson(item));
          }
          // Mengurutkan datalist berdasarkan sent_at (terbaru di paling bawah)
          datalist.sort((a, b) => b.sentAt.compareTo(a.sentAt));
          // Update UI
          isFirstChat = false;
          update();
          chatRoomCon.FetchData();
          chatRoomCon.update();
          sendPushMessagesChat(token_sender, "${authModel.nama}",
              "${textController.text}", "chat_masuk", jsonDecode(responseData));
          textController.clear();
          //logInfo("${jsonEncode(datalist)}");
          // Lakukan sesuatu dengan responseData
        } else {
          // Mengolah respons jika gagal
          logInfo("Failed to send message: ${response.statusMessage}");
        }
      } catch (e) {
        // Menangani error
        print("Error: $e");
      }

      update();
    }
  }

  Future<void> FetchData(roomID) async {
    datalist.clear();
    try {
      isLoading = true;

      final datauser = await getChat(roomID);

      if (datauser == null) {
        isFailed = true;
      } else if (datauser.isEmpty) {
        isEmpty = true;
      } else {
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

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        if (message.data['desc'] == "chat_masuk") {
          var decodedResponse = jsonDecode(message.data['json_value']);

          // Ambil data dari decodedResponse
          var data = decodedResponse['data'];
          // Iterasi melalui setiap item di 'data' dan tambahkan ke datalist
          for (var item in data) {
            datalist.add(ModelChat.fromJson(item));
          }
          // Mengurutkan datalist berdasarkan sent_at (terbaru di paling bawah)
          datalist.sort((a, b) => b.sentAt.compareTo(a.sentAt));

          // Update UI
          update();
          //chatRoomCon.FetchData();
        }

        //Get.toNamed(Routes.LAPOR_PAJAK, arguments: authModel);
      }
    });
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
