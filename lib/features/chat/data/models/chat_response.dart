import 'package:smart_service_marketplace/core/models/pagination_link.dart';
import 'package:smart_service_marketplace/features/chat/data/models/chat.dart';

class ChatResponse {
  final List<PaginationLink> pagination;
  final List<Chat> chats;
  const ChatResponse({required this.pagination, required this.chats});
  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      pagination: (json['pagination'] as List)
          .map((e) => PaginationLink.fromJson(e))
          .toList(),
      chats: (json['data']['chats'] as List)
          .map((e) => Chat.fromJson(e))
          .toList(),
    );
  }
}
