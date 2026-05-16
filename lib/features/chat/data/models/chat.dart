import 'package:smart_service_marketplace/features/chat/data/models/message.dart';

class Chat {
  final int id;
  final String userId;
  final String providerId;
  final Message lastMessage;
  final String userName;
  final String providerName;
  const Chat({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.lastMessage,
    required this.userName,
    required this.providerName,
  });
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      userId: json['user_id'],
      providerId: json['provider_id'],
      lastMessage: Message.fromJson(json['last_message']),
      userName: json['user_name'],
      providerName: json['provider_name'],
    );
  }
}
