import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/errors/server_failure.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_message.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_messages_page.dart';
import 'package:smart_service_market_place/features/chat/model/repos/chat_repo.dart';

@LazySingleton(as: ChatRepo)
class ChatRepoImpl implements ChatRepo {
  ChatRepoImpl(this._dioService);

  final DioService _dioService;

  Map<String, String> _headers(String token) => {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> _map(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    throw const FormatException(
      'The chat server returned an invalid response.',
    );
  }

  Future<Either<Failure, T>> _request<T>(Future<T> Function() request) async {
    try {
      return right(await request());
    } on DioException catch (error) {
      return left(ServerFailuer.fromDioError(dioException: error));
    } on FormatException catch (error) {
      return left(Failure(message: error.message));
    } catch (error) {
      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Chat>>> getChats({required String token}) =>
      _request(() async {
        final response = await _dioService.get(
          path: 'chats',
          headers: _headers(token),
        );
        final data = _map(response.data);
        return ((data['data'] as List<dynamic>? ?? const [])
            .map((item) => Chat.fromMap(item as Map<String, dynamic>))
            .toList());
      });

  @override
  Future<Either<Failure, Chat>> createChat({
    required String token,
    required int providerId,
  }) => _request(() async {
    final response = await _dioService.post(
      path: 'chats',
      headers: _headers(token),
      body: {'provider_id': providerId},
    );
    return Chat.fromMap(_map(response.data)['data'] as Map<String, dynamic>);
  });

  @override
  Future<Either<Failure, Chat>> getChat({
    required String token,
    required int chatId,
  }) => _request(() async {
    final response = await _dioService.get(
      path: 'chats/$chatId',
      headers: _headers(token),
    );
    return Chat.fromMap(_map(response.data)['data'] as Map<String, dynamic>);
  });

  @override
  Future<Either<Failure, ChatMessagesPage>> getMessages({
    required String token,
    required int chatId,
    String? cursor,
  }) => _request(() async {
    final response = await _dioService.get(
      path: 'chats/$chatId/messages',
      queryParameters: {'per_page': 30, 'cursor': ?cursor},
      headers: _headers(token),
    );
    return ChatMessagesPage.fromMap(_map(response.data));
  });

  @override
  Future<Either<Failure, ChatMessage>> sendMessage({
    required String token,
    required int chatId,
    required String message,
    required String clientMsgId,
  }) => _request(() async {
    final response = await _dioService.post(
      path: 'chats/$chatId/messages',
      headers: _headers(token),
      body: {'message': message, 'client_msg_id': clientMsgId},
    );
    return ChatMessage.fromMap(
      _map(response.data)['data'] as Map<String, dynamic>,
    );
  });

  @override
  Future<Either<Failure, String>> deleteMessage({
    required String token,
    required int chatId,
    required int messageId,
  }) => _request(() async {
    final response = await _dioService.delete(
      path: 'chats/$chatId/messages/$messageId',
      headers: _headers(token),
    );
    return _map(response.data)['message'] as String? ??
        'Message deleted successfully';
  });

  Future<Either<Failure, String>> _updateMessageStatus({
    required String token,
    required int chatId,
    required List<int> messageIds,
    required String status,
  }) => _request(() async {
    if (messageIds.isEmpty) return '';
    final response = await _dioService.post(
      path: 'chats/$chatId/$status',
      headers: _headers(token),
      body: {'message_ids': messageIds},
    );
    return _map(response.data)['message'] as String? ?? '';
  });

  @override
  Future<Either<Failure, String>> markDelivered({
    required String token,
    required int chatId,
    required List<int> messageIds,
  }) => _updateMessageStatus(
    token: token,
    chatId: chatId,
    messageIds: messageIds,
    status: 'delivered',
  );

  @override
  Future<Either<Failure, String>> markRead({
    required String token,
    required int chatId,
    required List<int> messageIds,
  }) => _updateMessageStatus(
    token: token,
    chatId: chatId,
    messageIds: messageIds,
    status: 'read',
  );

  @override
  Future<Either<Failure, String>> setTyping({
    required String token,
    required int chatId,
    required bool isTyping,
  }) => _request(() async {
    final response = await _dioService.post(
      path: 'chats/$chatId/typing',
      headers: _headers(token),
      body: {'is_typing': isTyping},
    );
    return _map(response.data)['message'] as String? ?? '';
  });

  @override
  Future<Either<Failure, String>> updatePresence({required String token}) =>
      _request(() async {
        final response = await _dioService.post(
          path: 'presence/last-seen',
          headers: _headers(token),
        );
        return _map(response.data)['message'] as String? ?? '';
      });
}
