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
void sendPushMessagesMultiple(
    List<String> tokens, String title, String body, String desc) async {
  try {
    for (String token in tokens) {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${ApiFCM}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'desc': desc
            },
            "to": token,
          },
        ),
      );
    }
  } catch (e) {
    print("error sending push notifications: $e");
  }
}
