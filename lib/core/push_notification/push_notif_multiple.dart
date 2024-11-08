import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/dashboard/services/dashboard_services.dart';
import 'package:bapenda_getx2_admin/utils/app_const.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

void sendPushMessagesJatuhTempo(
    List<Map<String, String>> allTokens3, String desc) async {
  // Print to check the JSON format of jsonDecode
  print(jsonEncode(jsonDecode));

  final getAccess = GetAccess();
  // Ensure token is valid or refresh if expired
  await getAccess.checkAndRefreshToken();
  // Retrieve token from GetStorage (ensured fresh by checkAndRefreshToken)
  final box = GetStorage();
  final tokenAccess = box.read("token_access") ?? "";

  try {
    for (Map<String, String> tokenInfo in allTokens3) {
      String messageTitle =
          "Jatuh Tempo Pajak ${tokenInfo['name']} Anda 7 hari lagi";
      String messageBody =
          "Bayar lebih cepat untuk menghindari denda, Buka Aplikasi untuk melihat Detailnya";
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
              'token': tokenInfo['token'],
              'notification': {
                'title': messageTitle,
                'body': messageBody,
              },
              'data': {
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done',
                'desc': desc,
                'jatuh_tempo': tokenInfo['jatuh_tempo'],
                'name': tokenInfo['name']
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

      if (response.statusCode == 200) {
        print("Push notification sent successfully");
      } else {
        print(
            "Failed to send push notification. Status code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    }
  } catch (e) {
    print("Error sending push notification: $e");
  }
}

void sendPushMessagesChat(List<Map<String, String>> allTokens3, String title,
    String body, String desc,
    [Map<String, dynamic>? jsonDecode]) async {
  // Print to check the JSON format of jsonDecode
  print(jsonEncode(jsonDecode));

  final getAccess = GetAccess();
  // Ensure token is valid or refresh if expired
  await getAccess.checkAndRefreshToken();
  // Retrieve token from GetStorage (ensured fresh by checkAndRefreshToken)
  final box = GetStorage();
  final tokenAccess = box.read("token_access") ?? "";

  try {
    for (Map<String, String> tokenInfo in allTokens3) {
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
              'token': tokenInfo['token'],
              'notification': {
                'title': title,
                'body': body,
              },
              'data': {
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done',
                'desc': desc,
                'json_value':
                    jsonEncode(jsonDecode) // Encode jsonDecode as JSON string
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

      if (response.statusCode == 200) {
        print("Push notification sent successfully");
      } else {
        print(
            "Failed to send push notification. Status code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    }
  } catch (e) {
    print("Error sending push notification: $e");
  }
}
