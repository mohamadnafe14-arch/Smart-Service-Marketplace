import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smart_service_marketplace/core/models/pagination_link.dart';
import 'package:smart_service_marketplace/core/secrets/pusher_secrets.dart';
import 'package:smart_service_marketplace/features/chat/data/models/chat.dart';
import 'package:smart_service_marketplace/features/chat/data/repo/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final String token;
  final ChatRepo chatRepo;
  final List<Chat> _pendingChats = [];
  final int id;
  int currentPage = 1;
  final pusher = PusherChannelsFlutter.getInstance();
  ChatCubit({required this.token, required this.chatRepo, required this.id})
    : super(ChatInitial());
  Future<void> initPusher() async {
    await pusher.init(
      apiKey: kPusherKey,
      cluster: kPusherCluster,
      onEvent: (event) => _handleEvent(event),
    );
    await pusher.connect();
    await pusher.subscribe(channelName: "user.$id");
  }

  void _handleEvent(PusherEvent event) {
    if (isClosed) return;

    try {
      if (event.data == null) return;

      final decoded = event.data is String
          ? jsonDecode(event.data!)
          : event.data;

      debugPrint("decoded event data: $decoded");

      final data = decoded['chat'] ?? decoded;

      final isLoadedState =
          state is ChatLoaded ||
          state is ChatPaginationLoading ||
          state is ChatPaginationError;

      if (!isLoadedState) {
        if (event.eventName == "chat.created" ||
            event.eventName == ".chat.created") {
          final newChat = Chat.fromJson(data);

          final exists = _pendingChats.any((c) => c.id == newChat.id);

          if (!exists) {
            _pendingChats.add(newChat);
          } else {
            final index = _pendingChats.indexWhere((c) => c.id == newChat.id);

            _pendingChats[index] = newChat;

            _pendingChats.insert(0, _pendingChats.removeAt(index));
          }
        }

        return;
      }

      List<Chat> currentChats = [];
      List<PaginationLink> pagination;

      if (state is ChatLoaded) {
        final currentState = state as ChatLoaded;
        currentChats = List<Chat>.from(currentState.chats);
        pagination = currentState.pagination;
      } else if (state is ChatPaginationLoading) {
        final currentState = state as ChatPaginationLoading;
        currentChats = List<Chat>.from(currentState.chats);
        pagination = currentState.pagination;
      } else {
        final currentState = state as ChatPaginationError;
        currentChats = List<Chat>.from(currentState.chats);
        pagination = currentState.pagination;
      }

      if (event.eventName == "chat.created" ||
          event.eventName == ".chat.created") {
        final newChat = Chat.fromJson(data);

        final exists = currentChats.any((c) => c.id == newChat.id);

        if (!exists) {
          currentChats.insert(0, newChat);
        } else {
          final index = currentChats.indexWhere((c) => c.id == newChat.id);

          currentChats[index] = newChat;

          currentChats.insert(0, currentChats.removeAt(index));
        }
      }

      emit(ChatLoaded(chats: currentChats, pagination: pagination));
    } catch (e) {
      debugPrint("Error handling Pusher event: $e");
    }
  }

  Future<void> fetchChats() async {
    if (currentPage == 1) {
      emit(ChatLoading());
    } else {
      final currentState = state;
      if (currentState is ChatLoaded) {
        emit(
          ChatPaginationLoading(
            chats: currentState.chats,
            pagination: currentState.pagination,
          ),
        );
      }
    }
    final result = await chatRepo.getChats(token: token, page: currentPage);
    result.fold(
      (failure) {
        final currentState = state;
        if (currentState is ChatLoaded) {
          emit(
            ChatPaginationError(
              message: failure.message,
              chats: currentState.chats,
              pagination: currentState.pagination,
            ),
          );
        } else {
          emit(ChatError(message: failure.message));
        }
      },
      (response) {
        List<Chat> chats = [];
        if (currentPage == 1) {
          chats = List<Chat>.from(response.chats);
          for (var chat in _pendingChats) {
            final exists = chats.any((c) => c.id == chat.id);
            if (!exists) {
              chats.insert(0, chat);
            }
          }
          _pendingChats.clear();
        } else {
          final currentState = state;
          List<Chat> oldChats = [];
          if (currentState is ChatLoaded) {
            oldChats = currentState.chats;
          } else if (currentState is ChatPaginationLoading) {
            oldChats = currentState.chats;
          } else if (currentState is ChatPaginationError) {
            oldChats = currentState.chats;
          }
          chats = List<Chat>.from(oldChats)..addAll(response.chats);
        }
        emit(ChatLoaded(chats: chats, pagination: response.pagination));
      },
    );
  }

  Future<void> nextPage() async {
    currentPage++;
    await fetchChats();
  }

  @override
  Future<void> close() async {
    await pusher.unsubscribe(channelName: "user.$id");
    await pusher.disconnect();
    return super.close();
  }

  Future<void> init() async {
    await initPusher();
    await fetchChats();
  }
}
