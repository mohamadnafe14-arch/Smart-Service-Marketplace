import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/core/secrets/server_secrets.dart';

@lazySingleton
class ChatChannelAuthorizer {
  ChatChannelAuthorizer(this._dioService);

  final DioService _dioService;

  Future<Map<String, dynamic>> authorize({
    required String token,
    required String channelName,
    required String socketId,
  }) async {
    final endpoint = Uri.parse(baseUrl).resolve('../broadcasting/auth');
    final response = await _dioService.post(
      path: endpoint.toString(),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: {'socket_id': socketId, 'channel_name': channelName},
    );
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    throw const FormatException('Invalid chat channel authorization response.');
  }
}
