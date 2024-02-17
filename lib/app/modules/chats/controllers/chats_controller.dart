import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  late AuthModel authModel;
  TextEditingController textController = TextEditingController();
  final RxList<Map<String, dynamic>> documents = RxList<Map<String, dynamic>>();
  RxList listParticipants = [].obs;
  CollectionReference roomsCollection =
      FirebaseFirestore.instance.collection('rooms');
  CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  WriteBatch batch = FirebaseFirestore.instance.batch();

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchChat();
  }

  void fetchChat() {
    final roomID = Get.parameters['roomID'];

    // Listen to changes in the 'rooms' collection for the specific room
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomID)
        .snapshots()
        .listen((roomDoc) async {
      if (roomDoc.exists) {
        final Map<String, dynamic> roomDataRooms =
            roomDoc.data() as Map<String, dynamic>;
        final List<dynamic> participants = roomDataRooms['participants'];

        // Listen to changes in the 'chats' subcollection for the specific room
        FirebaseFirestore.instance
            .collection('rooms')
            .doc(roomID)
            .collection('chats')
            .orderBy('createdAt', descending: true)
            .snapshots()
            .listen((chatQuerySnapshot) async {
          final List<Map<String, dynamic>> updatedRooms = [];

          final participantFutures = participants.map((participant) =>
              FirebaseFirestore.instance
                  .collection('UserTokens')
                  .doc(participant)
                  .get());

          final participantSnapshots = await Future.wait(participantFutures);

          for (final room in chatQuerySnapshot.docs) {
            final Map<String, dynamic> roomDataChats =
                room.data() as Map<String, dynamic>;
            final List<Map<String, dynamic>> participantsInfo = [];

            for (int i = 0; i < participants.length; i++) {
              final DocumentSnapshot userDoc = participantSnapshots[i];

              if (userDoc.exists) {
                final Map<String, dynamic> userData =
                    userDoc.data() as Map<String, dynamic>;
                participantsInfo.add({
                  'participant': participants[i],
                  'avatar': userData['image'],
                  'nama': userData['nama'],
                });
              }
            }

            roomDataChats['participantsInfo'] = participantsInfo;
            updatedRooms.add(roomDataChats);
          }

          documents.assignAll(updatedRooms);
          update();
        });
      }
    });
  }

  Future sendChat() async {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
      update();
    } else {
      EasyLoading.show();

      //String postID = FirebaseFirestore.instance.collection('rooms').doc().id;

      final docUser = FirebaseFirestore.instance
          .collection('rooms')
          .doc('${Get.parameters['roomID']}');
      final docChat = docUser.collection('chats').doc();

      // final jsonroom = {
      //   'postID': authModel.nik,
      //   'nikFrom': authModel.nik,
      //   'participants': [''],
      //   'nikTo': '${Get.parameters['textTo']}',
      //   'read': false,
      //   'createdAt': FieldValue.serverTimestamp(),
      // };

      final jsonchat = {
        'nikFrom': authModel.nik,
        'nikTo': '${Get.parameters['textTo']}',
        'text': textController.text,
        'read': false,
        'foto': authModel.foto,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // await docUser.set(jsonroom).whenComplete(() {
      //   print("berhasil buat rooms");
      // });
      await docChat.set(jsonchat).whenComplete(() async {
        await docUser.update({
          'lastText': textController.text,
          'readBy': ['${authModel.nik}'],
          'createdAt':
              FieldValue.serverTimestamp(), //update lasttext buat rooms
        }).whenComplete(
          () async {
            EasyLoading.dismiss();
            print("berhasil chat");
            DocumentSnapshot snap = await FirebaseFirestore.instance
                .collection("UserTokens")
                .doc(Get.parameters['textTo'])
                .get();
            String token = snap['token'];
            //print(token);
            sendPushMessage(
                token, "${authModel.nik}", "${textController.text}", "chat");
            FocusManager.instance.primaryFocus?.unfocus(); //dismiss keyboard
            hapusisi();
          },
        );
      }).catchError((error) {
        EasyLoading.dismiss();
        RawSnackbar_top(
            message: "Gagal Mengirim Chat", kategori: "error", duration: 1);
      });
      update();
    }
  }

  void updateRead() async {
    final docUser = FirebaseFirestore.instance
        .collection('rooms')
        .doc('${Get.parameters['roomID']}');
    final docChat = docUser.collection('chats');

    await docUser.update({
      'readBy': ['${authModel.nik}', '${Get.parameters['textTo']}']
    }).then((value) {
      docChat
          .where('nikTo', isEqualTo: authModel.nik.toString())
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((document) {
          batch.update(document.reference, {'read': true});
        });
        batch.commit();
      });
    });

    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    Get.parameters.clear();
  }

  void hapusisi() {
    textController.clear();
  }
}
