import 'chat_message.dart';

class ChatMessagesPage {
  const ChatMessagesPage({
    required this.messages,
    required this.nextCursor,
    required this.hasMore,
  });

  final List<ChatMessage> messages;
  final String? nextCursor;
  final bool hasMore;

  factory ChatMessagesPage.fromMap(Map<String, dynamic> map) {
    final pagination = map['pagination'] as Map<String, dynamic>? ?? const {};
    return ChatMessagesPage(
      messages: ((map['data'] as List<dynamic>? ?? const [])
          .map((item) => ChatMessage.fromMap(item as Map<String, dynamic>))
          .toList()),
      nextCursor: pagination['next_cursor'] as String?,
      hasMore: pagination['has_more'] as bool? ?? false,
    );
  }
}
