import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/chat/models/model_chat.dart';
import 'package:bapenda_getx2_admin/app/modules/chat_room/controllers/chat_room_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2_admin/widgets/logger.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  late AuthModel authModel;
  RxList<ModelChat> datalist = <ModelChat>[].obs;
  TextEditingController textController = TextEditingController();
  String? roomID;
  String? id_sender;
  String? nik_sender;
  String? sender_name;
  final ChatRoomController chatRoomCon = Get.find();

  @override
  void onInit() {
    super.onInit();
    listenFCM();
    authModel = Get.arguments;
    roomID = Get.parameters['room_id'];
    id_sender = Get.parameters['id_sender'];
    nik_sender = Get.parameters['nik_sender'];
    sender_name = Get.parameters['sender_name'];
    FetchData(roomID);
    readChat(int.parse("${authModel.idUserwp}"), roomID).then((value) {
      chatRoomCon.FetchData();
    });
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
          'room_id': '${roomID}',
          'text': '${textController.text}',
          'type': 'lama',
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
          update();
          DocumentSnapshot snap = await FirebaseFirestore.instance
              .collection("UserTokens")
              .doc(nik_sender)
              .get();
          String token_target = snap['token'];
          sendPushMessage(token_target, "${authModel.nama}",
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
      sendChat({
        'id_userwp': '${authModel.idUserwp}',
        'id_sender': '${id_sender}',
        'text': '${textController.text}',
        'type': 'baru',
      });

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
