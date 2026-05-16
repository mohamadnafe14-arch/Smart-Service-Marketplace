import 'package:smart_service_marketplace/core/models/pagination_link.dart';
import 'package:smart_service_marketplace/features/chat/data/models/message_in_days.dart';

class MessagesResponse {
  final MessageInDays messagesInDays;
  final List<PaginationLink> pagination;
  const MessagesResponse({
    required this.messagesInDays,
    required this.pagination,
  });
  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    return MessagesResponse(
      messagesInDays: MessageInDays.fromJson(json['data']['messages_in_days']),
      pagination: (json['pagination'] as List)
          .map((e) => PaginationLink.fromJson(e))
          .toList(),
    );
  }
}
