import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/models/model_getpendaftaran.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatRoomsController extends GetxController {
  late AuthModel authModel;
  final RxList<Map<String, dynamic>> room_list = RxList<Map<String, dynamic>>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isLoading = false;
  RxList<ModelGetPendaftaran> datalist = <ModelGetPendaftaran>[].obs;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchRooms();
  }

  void fetchRooms() {
    FirebaseFirestore.instance
        .collection('rooms')
        .where('participants', arrayContains: 'admin')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((chatQuerySnapshot) async {
      final List<Map<String, dynamic>> updatedRooms = [];
      final Map<String, Map<String, dynamic>> userCache = {};

      await Future.forEach(chatQuerySnapshot.docs, (room) async {
        final Map<String, dynamic> roomData =
            room.data() as Map<String, dynamic>;
        final List<dynamic> participants = roomData['participants'];
        final List<Map<String, dynamic>> participantsInfo = [];

        // Fetch all user data in parallel
        await Future.wait(participants.map((participant) async {
          if (userCache.containsKey(participant)) {
            participantsInfo.add(userCache[participant]!);
          } else {
            final DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection('UserTokens')
                .doc(participant)
                .get();

            if (userDoc.exists) {
              final Map<String, dynamic> userData =
                  userDoc.data() as Map<String, dynamic>;
              final participantInfo = {
                'participant': participant,
                'avatar': userData['image'],
                'nama': userData['nama'],
              };
              userCache[participant] = participantInfo;
              participantsInfo.add(participantInfo);
            }
          }
        }));

        roomData['participantsInfo'] = participantsInfo;
        updatedRooms.add(roomData);
      });

      room_list.assignAll(updatedRooms);
      update();
    });
  }

  Future<int> checkRoom({required String textTo}) async {
    QuerySnapshot roomQuerySnapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .where('participants', arrayContains: textTo)
        .get(); // Use get() to fetch data once

    int snapshotLength = roomQuerySnapshot.docs.length;
    return snapshotLength;
  }

  Future<String?> openChat(String textTo) async {
    QuerySnapshot roomQuerySnapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .where('participants', arrayContains: textTo)
        .get();

    if (roomQuerySnapshot.docs.isNotEmpty) {
      // Select the first document from the query results
      DocumentSnapshot selectedDocument = roomQuerySnapshot.docs[0];
      return selectedDocument.id;
    }

    // Return null when no matching documents are found
    return null;
  }

  Future createRoom(String textTo) async {
    String postID = FirebaseFirestore.instance.collection('rooms').doc().id;
    final docUser = FirebaseFirestore.instance.collection('rooms').doc(postID);
    final jsonroom = {
      'postID': postID,
      'nikFrom': authModel.nik,
      'nikTo': '${textTo}',
      'read': false,
      'lastText': "",
      'participants': ['${authModel.nik}', '${textTo}'],
      'readBy': ['${authModel.nik}'],
      'createdAt': FieldValue.serverTimestamp(),
    };
    await docUser.set(jsonroom).whenComplete(() {
      print("berhasil buat rooms");
    }).whenComplete(
      () {
        Get.toNamed(Routes.CHATS, arguments: authModel, parameters: {
          'roomID': '${postID}',
          'textTo': '${textTo}',
          'namaTo': '${textTo}',
          'createRoom': 'yes'
        });
      },
    );
  }

  Future fetchWP() async {
    final url = Uri.parse(
        '${URL_APP_API}/get_pendaftaran_admin/index.php?page=1&limit=50');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List newItems =
          (json.decode(response.body) as Map<String, dynamic>)["data"];

      final list = newItems.map<ModelGetPendaftaran>(
          (json) => ModelGetPendaftaran.fromJson(json));

      isLoading = false;

      datalist.addAll(list);

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
