import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:http/http.dart' as http;

// void sendPushMessagesMultiple(
//     List<String> tokens, String title, String body, String desc) async {
//   try {
//     for (String token in tokens) {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=${ApiFCM}',
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             'notification': <String, dynamic>{
//               'body': body,
//               'title': title,
//             },
//             'priority': 'high',
//             'data': <String, dynamic>{
//               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//               'id': '1',
//               'status': 'done',
//               'desc': desc
//             },
//             "to": token,
//           },
//         ),
//       );
//     }
//   } catch (e) {
//     print("error sending push notifications: $e");
//   }
// }
void sendPushMessagesJatuhTempo(
    List<Map<String, String>> allTokens3,  String desc) async {
  try {
    for (Map<String, String> tokenInfo in allTokens3) {
      String messageTitle = "Jatuh Tempo Pajak ${tokenInfo['name']} Anda 7 hari lagi";
    String messageBody = "Bayar lebih cepat untuk menghindari denda, Buka Aplikasi untuk melihat Detailnya";
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${ApiFCM}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': messageBody,
              'title': messageTitle,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'desc': desc,
              'jatuh_tempo': tokenInfo['jatuh_tempo'],
              'name': tokenInfo['name'],
            },
            "to": tokenInfo['token'],
          },
        ),
      );
    }
    
  } catch (e) {
    print("error sending push notifications: $e");
  }
}