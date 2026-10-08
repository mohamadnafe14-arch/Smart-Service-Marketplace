import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_service_market_place/core/secrets/server_secrets.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/features/chat/model/services/chat_channel_authorizer.dart';

class MockDioService extends Mock implements DioService {}

void main() {
  late MockDioService dioService;
  late ChatChannelAuthorizer authorizer;

  setUp(() {
    dioService = MockDioService();
    authorizer = ChatChannelAuthorizer(dioService);
  });

  test(
    'authorizes private channels with the bearer token and Pusher IDs',
    () async {
      final endpoint = Uri.parse(
        baseUrl,
      ).resolve('../broadcasting/auth').toString();
      when(
        () => dioService.post(
          path: endpoint,
          headers: {
            'Authorization': 'Bearer chat-token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: {'socket_id': '10.20', 'channel_name': 'private-chat.7'},
        ),
      ).thenAnswer(
        (_) async => Response<dynamic>(
          requestOptions: RequestOptions(path: endpoint),
          statusCode: 200,
          data: {'auth': 'signature', 'channel_data': '{"user_id":7}'},
        ),
      );

      final result = await authorizer.authorize(
        token: 'chat-token',
        channelName: 'private-chat.7',
        socketId: '10.20',
      );

      expect(result['auth'], 'signature');
      expect(result['channel_data'], '{"user_id":7}');
      verify(
        () => dioService.post(
          path: endpoint,
          headers: {
            'Authorization': 'Bearer chat-token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: {'socket_id': '10.20', 'channel_name': 'private-chat.7'},
        ),
      ).called(1);
    },
  );
}
