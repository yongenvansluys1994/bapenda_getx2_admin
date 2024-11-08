import 'dart:convert';

import 'package:bapenda_getx2_admin/app/modules/dashboard/services/dashboard_services.dart';
import 'package:bapenda_getx2_admin/utils/app_const.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

void sendPushMessage(
    String token, String title, String body, String desc) async {
  final getAccess = GetAccess();
  // Ensure token is valid or refresh if expired
  await getAccess.checkAndRefreshToken();
  // Retrieve token from GetStorage (ensured fresh by checkAndRefreshToken)
  final box = GetStorage();
  final tokenAccess = box.read("token_access") ?? "";

  try {
    final response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenAccess',
      },
      body: jsonEncode(
        <String, dynamic>{
          'message': {
            'token': token,
            'notification': {
              'title': title,
              'body': body,
            },
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'desc': desc,
            },
            'android': {
              'notification': {'click_action': 'TOP_STORY_ACTIVITY'}
            },
            'apns': {
              'payload': {
                'aps': {'category': 'NEW_MESSAGE_CATEGORY'}
              }
            }
          }
        },
      ),
    );

    // if (response.statusCode == 200) {
    //   print("Push notification sent successfully.");
    // } else {
    //   print("Failed to send push notification: ${response.body}");
    // }
  } catch (e) {
    print("Error sending push notification: $e");
  }
}

void sendPushMessageChat(String token, String title, String body, String desc,
    [jsonDecode]) async {
  final getAccess = GetAccess();
  // Ensure token is valid or refresh if expired
  await getAccess.checkAndRefreshToken();
  // Retrieve token from GetStorage (ensured fresh by checkAndRefreshToken)
  final box = GetStorage();
  final tokenAccess = box.read("token_access") ?? "";
  try {
    await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenAccess',
      },
      body: jsonEncode(
        <String, dynamic>{
          'message': {
            'token': token,
            'notification': {
              'title': title,
              'body': body,
            },
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'desc': desc,
              'json_value': jsonDecode
            },
            'android': {
              'notification': {'click_action': 'TOP_STORY_ACTIVITY'}
            },
            'apns': {
              'payload': {
                'aps': {'category': 'NEW_MESSAGE_CATEGORY'}
              }
            }
          },
        },
      ),
    );
  } catch (e) {
    print("error push notification");
  }
}
