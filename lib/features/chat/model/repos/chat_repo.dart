import 'package:fpdart/fpdart.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_messages_page.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_message.dart';

abstract interface class ChatRepo {
  Future<Either<Failure, List<Chat>>> getChats({required String token});

  Future<Either<Failure, Chat>> createChat({
    required String token,
    required int providerId,
  });

  Future<Either<Failure, Chat>> getChat({
    required String token,
    required int chatId,
  });

  Future<Either<Failure, ChatMessagesPage>> getMessages({
    required String token,
    required int chatId,
    String? cursor,
  });

  Future<Either<Failure, ChatMessage>> sendMessage({
    required String token,
    required int chatId,
    required String message,
    required String clientMsgId,
  });

  Future<Either<Failure, String>> deleteMessage({
    required String token,
    required int chatId,
    required int messageId,
  });

  Future<Either<Failure, String>> markDelivered({
    required String token,
    required int chatId,
    required List<int> messageIds,
  });

  Future<Either<Failure, String>> markRead({
    required String token,
    required int chatId,
    required List<int> messageIds,
  });

  Future<Either<Failure, String>> setTyping({
    required String token,
    required int chatId,
    required bool isTyping,
  });

  Future<Either<Failure, String>> updatePresence({required String token});
}
