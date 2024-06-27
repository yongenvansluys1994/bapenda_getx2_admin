// To parse this JSON data, do
//
//     final modelRuangChat = modelRuangChatFromJson(jsonString);

import 'dart:convert';

ModelRuangChat modelRuangChatFromJson(String str) =>
    ModelRuangChat.fromJson(json.decode(str));

String modelRuangChatToJson(ModelRuangChat data) => json.encode(data.toJson());

class ModelRuangChat {
  String roomId;
  dynamic roomName;
  String isGroup;
  String? type;
  String hasUnread;
  String? senderName;
  String? foto;
  String? idSender;
  String? nikSender;
  DateTime sentAt;
  String lastMessageText;

  ModelRuangChat({
    required this.roomId,
    required this.roomName,
    required this.isGroup,
    required this.type,
    required this.hasUnread,
    required this.senderName,
    required this.foto,
    required this.idSender,
    required this.nikSender,
    required this.sentAt,
    required this.lastMessageText,
  });

  factory ModelRuangChat.fromJson(Map<String, dynamic> json) => ModelRuangChat(
        roomId: json["room_id"],
        roomName: json["room_name"],
        isGroup: json["is_group"],
        type: json["type"],
        hasUnread: json["has_unread"],
        senderName: json["sender_name"],
        foto: json["foto"],
        idSender: json["id_sender"],
        nikSender: json["nik_sender"],
        sentAt: DateTime.parse(json["sent_at"]),
        lastMessageText: json["last_message_text"],
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "room_name": roomName,
        "is_group": isGroup,
        "type": type,
        "has_unread": hasUnread,
        "sender_name": senderName,
        "foto": foto,
        "id_sender": idSender,
        "nik_sender": nikSender,
        "sent_at": sentAt.toIso8601String(),
        "last_message_text": lastMessageText,
      };
}
