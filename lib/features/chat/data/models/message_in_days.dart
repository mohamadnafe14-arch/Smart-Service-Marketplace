import 'package:smart_service_marketplace/features/chat/data/models/message.dart';

class MessageInDays {
  final int id;
  final int chatId;
  final List<Message> messages;
  final String createdAt;

const  MessageInDays({
    required this.id,
    required this.chatId,
    required this.messages,
    required this.createdAt,
  });
  factory MessageInDays.fromJson(Map<String, dynamic> json) {
    return MessageInDays(
      id: json['id'],
      chatId: json['chat_id'],
      messages: List<Message>.from(json['messages'].map((x) => Message.fromJson(x))),
      createdAt: json['created_at'],
    );
  }
}
