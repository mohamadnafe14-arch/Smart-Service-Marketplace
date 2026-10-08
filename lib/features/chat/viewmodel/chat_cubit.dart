import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smart_service_market_place/core/services/realtime_service.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_cubit_params.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_message.dart';
import 'package:smart_service_market_place/features/chat/model/repos/chat_repo.dart';
import 'package:smart_service_market_place/features/chat/viewmodel/chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    @factoryParam required this.params,
    required this.chatRepo,
    required this.realtimeService,
  }) : super(const ChatState());

  final ChatCubitParams params;
  final ChatRepo chatRepo;
  final RealtimeService realtimeService;
  Timer? _heartbeat;
  Timer? _typingTimer;
  bool _chatChannelSubscribed = false;
  bool _userChannelSubscribed = false;
  bool _isTyping = false;
  String get _userChannelName => 'private-user.${params.userId}';
  String _chatChannelName(int chatId) => 'presence-chat.$chatId';

  Future<void> loadChats() async {
    emit(state.copyWith(status: ChatStatus.loading, clearError: true));
    final result = await chatRepo.getChats(token: params.token);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ChatStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (chats) {
        emit(state.copyWith(status: ChatStatus.loaded, chats: chats));
        _startHeartbeat();
        unawaited(_subscribeToUserChannel());
      },
    );
  }

  Future<void> refreshChats() async {
    final result = await chatRepo.getChats(token: params.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (chats) => emit(state.copyWith(chats: chats, status: ChatStatus.loaded)),
    );
  }

  Future<Chat?> createConversation(int providerId) async {
    final result = await chatRepo.createChat(
      token: params.token,
      providerId: providerId,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return null;
      },
      (chat) {
        final chats = [
          chat,
          ...state.chats.where((item) => item.id != chat.id),
        ];
        emit(state.copyWith(chats: chats));
        return chat;
      },
    );
  }

  Future<void> openChat(Chat chat) async {
    _startHeartbeat();
    emit(
      state.copyWith(
        status: ChatStatus.loading,
        activeChat: chat,
        messages: const [],
        clearCursor: true,
        hasMore: false,
        clearError: true,
      ),
    );
    final realtimeError = await _subscribeToChat(chat.id);
    final chatResult = await chatRepo.getChat(
      token: params.token,
      chatId: chat.id,
    );
    String? chatError;
    final refreshedChat = chatResult.fold((failure) {
      chatError = failure.message;
      return chat;
    }, (value) => value);
    emit(state.copyWith(activeChat: refreshedChat));
    await loadMessages();
    final error = chatError ?? realtimeError;
    if (error != null && !isClosed) {
      emit(state.copyWith(errorMessage: error));
    }
  }

  Future<void> openProviderConversation(int providerId) async {
    emit(state.copyWith(status: ChatStatus.loading, clearError: true));
    final chat = await createConversation(providerId);
    if (chat != null) await openChat(chat);
  }

  Future<void> loadMessages({bool loadOlder = false}) async {
    final chat = state.activeChat;
    if (chat == null ||
        (loadOlder && (!state.hasMore || state.isLoadingMore))) {
      return;
    }
    if (loadOlder) {
      emit(state.copyWith(isLoadingMore: true));
    } else {
      emit(state.copyWith(status: ChatStatus.loading, clearError: true));
    }

    final result = await chatRepo.getMessages(
      token: params.token,
      chatId: chat.id,
      cursor: loadOlder ? state.nextCursor : null,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: loadOlder ? ChatStatus.loaded : ChatStatus.failure,
          isLoadingMore: false,
          errorMessage: failure.message,
        ),
      ),
      (page) {
        final incoming = page.messages.reversed.toList();
        final messages = loadOlder
            ? [...incoming, ...state.messages]
            : incoming;
        emit(
          state.copyWith(
            status: ChatStatus.loaded,
            messages: _uniqueMessages(messages),
            nextCursor: page.nextCursor,
            clearCursor: page.nextCursor == null,
            hasMore: page.hasMore,
            isLoadingMore: false,
          ),
        );
        unawaited(_acknowledgeIncomingMessages());
      },
    );
  }

  Future<void> sendMessage(String text, {String? clientMsgId}) async {
    final chat = state.activeChat;
    final message = text.trim();
    if (chat == null || message.isEmpty) return;
    if (message.length > 5000) {
      emit(
        state.copyWith(errorMessage: 'Messages can be up to 5000 characters.'),
      );
      return;
    }

    final requestId = clientMsgId ?? _newClientMessageId();
    final optimisticMessage = ChatMessage(
      id: -DateTime.now().microsecondsSinceEpoch,
      chatId: chat.id,
      senderId: params.userId,
      isSender: true,
      message: message,
      status: 'sent',
      clientMsgId: requestId,
      createdAt: DateTime.now().toUtc().toIso8601String(),
      isSending: true,
    );
    emit(
      state.copyWith(
        messages: [...state.messages, optimisticMessage],
        clearError: true,
      ),
    );
    await setTyping(false);

    final result = await chatRepo.sendMessage(
      token: params.token,
      chatId: chat.id,
      message: message,
      clientMsgId: requestId,
    );
    result.fold(
      (failure) {
        final messages = state.messages.map((item) {
          return item.clientMsgId == requestId
              ? item.copyWith(isSending: false, hasFailed: true)
              : item;
        }).toList();
        emit(state.copyWith(messages: messages, errorMessage: failure.message));
      },
      (sentMessage) {
        _upsertMessage(sentMessage);
        unawaited(refreshChats());
      },
    );
  }

  Future<void> retryMessage(ChatMessage failedMessage) async {
    if (failedMessage.hasFailed) {
      emit(
        state.copyWith(
          messages: state.messages
              .where(
                (message) => message.clientMsgId != failedMessage.clientMsgId,
              )
              .toList(),
          clearError: true,
        ),
      );
      await sendMessage(
        failedMessage.message,
        clientMsgId: failedMessage.clientMsgId,
      );
    }
  }

  Future<void> deleteMessage(ChatMessage message) async {
    final chat = state.activeChat;
    if (chat == null || !message.isSender || message.id < 0) return;
    final result = await chatRepo.deleteMessage(
      token: params.token,
      chatId: chat.id,
      messageId: message.id,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => emit(
        state.copyWith(
          messages: state.messages
              .where((item) => item.id != message.id)
              .toList(),
        ),
      ),
    );
  }

  Future<void> setTyping(bool isTyping) async {
    final chat = state.activeChat;
    if (chat == null) return;
    _typingTimer?.cancel();
    if (isTyping) {
      _isTyping = true;
      _typingTimer = Timer(
        const Duration(milliseconds: 1400),
        () => unawaited(setTyping(false)),
      );
    } else {
      _isTyping = false;
    }
    final result = await chatRepo.setTyping(
      token: params.token,
      chatId: chat.id,
      isTyping: isTyping,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {},
    );
  }

  Future<void> _acknowledgeIncomingMessages() async {
    final chat = state.activeChat;
    if (chat == null) return;
    final incomingIds = state.messages
        .where((message) => !message.isSender && message.id > 0)
        .map((message) => message.id)
        .toList();
    if (incomingIds.isEmpty) return;
    final result = await chatRepo.markDelivered(
      token: params.token,
      chatId: chat.id,
      messageIds: incomingIds.take(100).toList(),
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) async {
        final readResult = await chatRepo.markRead(
          token: params.token,
          chatId: chat.id,
          messageIds: incomingIds.take(100).toList(),
        );
        readResult.fold(
          (failure) => emit(state.copyWith(errorMessage: failure.message)),
          (_) {},
        );
      },
    );
  }

  void _startHeartbeat() {
    _heartbeat ??= Timer.periodic(
      const Duration(minutes: 5),
      (_) => unawaited(_sendHeartbeat()),
    );
    unawaited(_sendHeartbeat());
  }

  Future<void> _sendHeartbeat() async {
    final result = await chatRepo.updatePresence(token: params.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {},
    );
  }

  Future<void> _subscribeToUserChannel() async {
    try {
      await realtimeService.subscribe(
        channelName: _userChannelName,
        token: params.token,
        onEvent: _handleRealtimeEvent,
        onError: _handleRealtimeError,
      );
      _userChannelSubscribed = true;
    } on Exception catch (error) {
      debugPrint('Chat realtime subscription failed: $error');
      emit(
        state.copyWith(
          errorMessage: 'Live message notifications are unavailable.',
        ),
      );
    }
  }

  Future<String?> _subscribeToChat(int chatId) async {
    try {
      await realtimeService.subscribe(
        channelName: _chatChannelName(chatId),
        token: params.token,
        onEvent: _handleRealtimeEvent,
        onError: _handleRealtimeError,
      );
      _chatChannelSubscribed = true;
      return null;
    } on Exception catch (error) {
      debugPrint('Chat realtime subscription failed: $error');
      return 'Live updates are temporarily unavailable.';
    }
  }

  void _handleRealtimeError(String message) {
    if (!isClosed) {
      emit(state.copyWith(errorMessage: 'Chat connection issue: $message'));
    }
  }

  void _handleRealtimeEvent(PusherEvent event) {
    if (isClosed) return;
    try {
      final dynamic decoded = event.data is String
          ? jsonDecode(event.data as String)
          : event.data;
      if (decoded is! Map) return;
      final data = Map<String, dynamic>.from(decoded);
      final eventName = event.eventName.startsWith('.')
          ? event.eventName.substring(1)
          : event.eventName;
      switch (eventName) {
        case 'message.sent':
          final messageMap = data['message'];
          if (messageMap is Map) {
            final message = ChatMessage.fromMap(
              Map<String, dynamic>.from(messageMap),
            );
            if (message.chatId == state.activeChat?.id) {
              _upsertMessage(message);
              if (!message.isSender) unawaited(_acknowledgeIncomingMessages());
            }
            unawaited(refreshChats());
          }
          break;
        case 'message.delivered':
        case 'message.read':
          if (data['chat_id'] == state.activeChat?.id) {
            _updateStatuses(
              data,
              eventName == 'message.read' ? 'read' : 'delivered',
            );
          }
          break;
        case 'typing.started':
          if (data['chat_id'] == state.activeChat?.id &&
              data['user_id'] != params.userId) {
            emit(state.copyWith(peerIsTyping: true));
          }
          break;
        case 'typing.stopped':
          if (data['chat_id'] == state.activeChat?.id) {
            emit(state.copyWith(peerIsTyping: false));
          }
          break;
      }
    } on FormatException catch (error) {
      debugPrint('Invalid chat realtime payload: $error');
    } on TypeError catch (error) {
      debugPrint('Invalid chat realtime payload: $error');
    }
  }

  void _updateStatuses(Map<String, dynamic> data, String status) {
    final ids = (data['message_ids'] as List<dynamic>? ?? const [])
        .whereType<num>()
        .map((id) => id.toInt())
        .toSet();
    final timestamp =
        (status == 'read' ? data['read_at'] : data['delivered_at']) as String?;
    emit(
      state.copyWith(
        messages: state.messages.map((message) {
          if (!ids.contains(message.id)) return message;
          return message.copyWith(
            status: status,
            deliveredAt: timestamp,
            readAt: status == 'read' ? timestamp : message.readAt,
          );
        }).toList(),
      ),
    );
  }

  void _upsertMessage(ChatMessage message) {
    final messages = List<ChatMessage>.from(state.messages);
    final index = messages.indexWhere(
      (item) =>
          item.id == message.id ||
          (item.clientMsgId != null && item.clientMsgId == message.clientMsgId),
    );
    if (index == -1) {
      messages.add(message);
    } else {
      messages[index] = message;
    }
    messages.sort((a, b) {
      final aTime = DateTime.tryParse(a.createdAt ?? '');
      final bTime = DateTime.tryParse(b.createdAt ?? '');
      return (aTime ?? DateTime.fromMillisecondsSinceEpoch(a.id.abs()))
          .compareTo(bTime ?? DateTime.fromMillisecondsSinceEpoch(b.id.abs()));
    });
    emit(state.copyWith(messages: messages));
  }

  List<ChatMessage> _uniqueMessages(List<ChatMessage> messages) {
    final unique = <String, ChatMessage>{};
    for (final message in messages) {
      unique['${message.id}:${message.clientMsgId ?? ''}'] = message;
    }
    return unique.values.toList();
  }

  String _newClientMessageId() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  @override
  Future<void> close() async {
    if (_isTyping && state.activeChat != null) await setTyping(false);
    _heartbeat?.cancel();
    _typingTimer?.cancel();
    if (_userChannelSubscribed) {
      await realtimeService.unsubscribe(
        channelName: _userChannelName,
        onEvent: _handleRealtimeEvent,
        onError: _handleRealtimeError,
      );
    }
    if (_chatChannelSubscribed && state.activeChat != null) {
      await realtimeService.unsubscribe(
        channelName: _chatChannelName(state.activeChat!.id),
        onEvent: _handleRealtimeEvent,
        onError: _handleRealtimeError,
      );
    }
    return super.close();
  }
}
