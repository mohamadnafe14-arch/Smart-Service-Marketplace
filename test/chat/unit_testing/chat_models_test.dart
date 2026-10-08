import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_message.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_messages_page.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_peer.dart';

void main() {
  group('Chat models', () {
    test('parses a peer including nullable provider details', () {
      final peer = ChatPeer.fromMap({
        'id': 9,
        'name': 'Samir',
        'role': 'provider',
        'phone': null,
        'category': 'Plumbing',
        'rate': 4.5,
        'last_seen_at': null,
      });

      expect(peer.id, 9);
      expect(peer.name, 'Samir');
      expect(peer.rate, 4.5);
      expect(peer.phone, isNull);
      expect(peer.lastSeenAt, isNull);
    });

    test('parses a chat with optional last message', () {
      final chat = Chat.fromMap({
        'id': 12,
        'user_id': 4,
        'provider_id': 9,
        'peer': {'id': 9, 'name': 'Samir', 'role': 'provider'},
        'last_message': {
          'id': 88,
          'chat_id': 12,
          'sender_id': 4,
          'is_sender': true,
          'message': 'Hello there',
          'status': 'sent',
        },
        'last_message_at': null,
        'unread_count': 2,
        'created_at': null,
      });

      expect(chat.id, 12);
      expect(chat.peer?.name, 'Samir');
      expect(chat.lastMessage?.message, 'Hello there');
      expect(chat.unreadCount, 2);

      final emptyChat = Chat.fromMap({
        'id': 13,
        'user_id': 4,
        'provider_id': 10,
        'peer': null,
        'last_message': null,
        'unread_count': 0,
      });
      expect(emptyChat.peer, isNull);
      expect(emptyChat.lastMessage, isNull);
      expect(emptyChat.unreadCount, 0);
    });

    test('parses descending server page metadata and message fields', () {
      final page = ChatMessagesPage.fromMap({
        'data': [
          {
            'id': 5,
            'chat_id': 12,
            'sender_id': 9,
            'is_sender': false,
            'client_msg_id': null,
            'message': 'A reply',
            'status': 'delivered',
            'delivered_at': '2026-10-01T10:00:00Z',
            'read_at': null,
            'created_at': '2026-10-01T10:00:00Z',
            'created_at_human': 'just now',
          },
          {
            'id': 4,
            'chat_id': 12,
            'sender_id': 4,
            'is_sender': true,
            'client_msg_id': 'c1',
            'message': 'Question',
            'status': 'read',
          },
        ],
        'pagination': {
          'next_cursor': 'opaque-cursor',
          'prev_cursor': null,
          'has_more': true,
        },
      });

      expect(page.messages.map((message) => message.id), [5, 4]);
      expect(page.messages.first.status, 'delivered');
      expect(page.messages.first.isSender, isFalse);
      expect(page.nextCursor, 'opaque-cursor');
      expect(page.hasMore, isTrue);
    });

    test('copyWith updates delivery state without losing message data', () {
      const message = ChatMessage(
        id: 1,
        chatId: 3,
        senderId: 4,
        isSender: true,
        message: 'Hi',
        status: 'sent',
      );

      final delivered = message.copyWith(
        status: 'delivered',
        deliveredAt: '2026-10-01T10:00:00Z',
      );

      expect(delivered.message, 'Hi');
      expect(delivered.status, 'delivered');
      expect(delivered.deliveredAt, isNotNull);
    });
  });
}
