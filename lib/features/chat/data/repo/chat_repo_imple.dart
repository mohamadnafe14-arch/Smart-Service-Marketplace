import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/chat/data/models/chat_response.dart';
import 'package:smart_service_marketplace/features/chat/data/models/messages_response.dart';
import 'package:smart_service_marketplace/features/chat/data/repo/chat_repo.dart';
import 'package:http/http.dart' as http;

class ChatRepoImple implements ChatRepo {
  @override
  Future<Either<Failure, ChatResponse>> getChats({
    required String token,
    required int page,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${kBaseUrl}api/chat?page=$page'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }
      );
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return right(ChatResponse.fromJson(body));
      } else {
        return left(Failure(body['message']));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessagesResponse>> getMessages({
    required String recieverId,
    required String token,
    required int page,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${kBaseUrl}api/chat/$recieverId?page=$page'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }
      );
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return right(MessagesResponse.fromJson(body));
      } else {
        return left(Failure(body['message']));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendMessage({
    required String receiverId,
    required String message,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${kBaseUrl}api/chat/$receiverId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': message,
        }),
      );
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return right(body['message']);
      } else {
        return left(Failure(body['message']));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
