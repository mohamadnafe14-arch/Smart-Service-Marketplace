import 'chat_message.dart';
import 'chat_peer.dart';

class Chat {
  const Chat({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.unreadCount,
    this.peer,
    this.lastMessage,
    this.lastMessageAt,
    this.createdAt,
  });

  final int id;
  final int userId;
  final int providerId;
  final int unreadCount;
  final ChatPeer? peer;
  final ChatMessage? lastMessage;
  final String? lastMessageAt;
  final String? createdAt;

  factory Chat.fromMap(Map<String, dynamic> map) => Chat(
    id: map['id'] as int,
    userId: map['user_id'] as int,
    providerId: map['provider_id'] as int,
    peer: map['peer'] is Map<String, dynamic>
        ? ChatPeer.fromMap(map['peer'] as Map<String, dynamic>)
        : null,
    lastMessage: map['last_message'] is Map<String, dynamic>
        ? ChatMessage.fromMap(map['last_message'] as Map<String, dynamic>)
        : null,
    lastMessageAt: map['last_message_at'] as String?,
    unreadCount: map['unread_count'] as int? ?? 0,
    createdAt: map['created_at'] as String?,
  );
}
