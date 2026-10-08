import 'package:flutter/foundation.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_message.dart';

enum ChatStatus { initial, loading, loaded, failure }

@immutable
class ChatState {
  const ChatState({
    this.status = ChatStatus.initial,
    this.chats = const [],
    this.messages = const [],
    this.activeChat,
    this.errorMessage,
    this.nextCursor,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.peerIsTyping = false,
  });

  final ChatStatus status;
  final List<Chat> chats;
  final List<ChatMessage> messages;
  final Chat? activeChat;
  final String? errorMessage;
  final String? nextCursor;
  final bool hasMore;
  final bool isLoadingMore;
  final bool peerIsTyping;

  ChatState copyWith({
    ChatStatus? status,
    List<Chat>? chats,
    List<ChatMessage>? messages,
    Chat? activeChat,
    bool clearActiveChat = false,
    String? errorMessage,
    bool clearError = false,
    String? nextCursor,
    bool clearCursor = false,
    bool? hasMore,
    bool? isLoadingMore,
    bool? peerIsTyping,
  }) => ChatState(
    status: status ?? this.status,
    chats: chats ?? this.chats,
    messages: messages ?? this.messages,
    activeChat: clearActiveChat ? null : activeChat ?? this.activeChat,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    nextCursor: clearCursor ? null : nextCursor ?? this.nextCursor,
    hasMore: hasMore ?? this.hasMore,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    peerIsTyping: peerIsTyping ?? this.peerIsTyping,
  );
}
