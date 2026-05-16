import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/chat/data/models/chat_response.dart';
import 'package:smart_service_marketplace/features/chat/data/models/message.dart';
import 'package:smart_service_marketplace/features/chat/data/models/messages_response.dart';

abstract class ChatRepo{

  Future<Either <Failure, String>> sendMessage({
    required String receiverId,
    required String message,
    required String token,
  });
  Future<Either<Failure,MessagesResponse>> getMessages({
    required String recieverId,
    required String token,
  });
  Future<Either<Failure,ChatResponse>> getChats({
    required String token,
  });
}